<?php
require_once 'db/conexion.php';
session_start();

$db     = getDB();
$modo   = $_GET['modo']   ?? 'completo';
$modulo = $_GET['modulo'] ?? null;

// Load questions
if ($modulo) {
    $stmt = $db->prepare("SELECT * FROM preguntas WHERE modulo_id = ? ORDER BY RAND()");
    $stmt->execute([$modulo]);
    $mod_info = $db->prepare("SELECT * FROM modulos WHERE id = ?");
    $mod_info->execute([$modulo]);
    $mod_row  = $mod_info->fetch();
    $titulo   = $mod_row ? $mod_row['nombre'] : 'Módulo';
} elseif ($modo === 'repaso') {
    // Only questions the user failed in their last test
    $last = $db->query("SELECT id FROM resultados ORDER BY fecha DESC LIMIT 1")->fetchColumn();
    if ($last) {
        $stmt = $db->prepare("
            SELECT p.* FROM preguntas p
            INNER JOIN respuestas_detalle rd ON rd.pregunta_id = p.id
            WHERE rd.resultado_id = ? AND rd.es_correcta = 0
            ORDER BY RAND()
        ");
        $stmt->execute([$last]);
    } else {
        $stmt = $db->query("SELECT * FROM preguntas ORDER BY RAND() LIMIT 65");
    }
    $titulo = 'Modo Repaso';
} else {
    $stmt   = $db->query("SELECT * FROM preguntas ORDER BY RAND() LIMIT 65");
    $titulo = 'Test Completo CLF-C02';
}

$preguntas = $stmt->fetchAll();

if (empty($preguntas)) {
    die('<p style="padding:40px;font-family:sans-serif">No hay preguntas disponibles. <a href="index.php">Volver</a></p>');
}

// Store session
$_SESSION['quiz_preguntas'] = array_column($preguntas, 'id');
$_SESSION['quiz_modo']      = $modo;
$_SESSION['quiz_modulo']    = $modulo;
$_SESSION['quiz_start']     = time();

// Shuffle answer options per question so the correct answer is not always the same letter
$shuffled_answers   = [];  // [qid => new_correct_letter]
$shuffled_questions = [];  // [qid => shuffled opcion_a..d + correct]

$preguntas_json = json_encode(array_map(function($p) use (&$shuffled_answers, &$shuffled_questions) {
    $texts = [$p['opcion_a'], $p['opcion_b'], $p['opcion_c'], $p['opcion_d']];
    $orig_correct_idx = ord($p['respuesta_correcta']) - ord('A'); // 0-3

    // Shuffle indices
    $idxs = [0, 1, 2, 3];
    shuffle($idxs);

    $new_texts = [$texts[$idxs[0]], $texts[$idxs[1]], $texts[$idxs[2]], $texts[$idxs[3]]];

    // Find where the original correct option ended up
    $new_correct_pos = array_search($orig_correct_idx, $idxs);
    $new_correct_key = chr(ord('A') + $new_correct_pos);

    $qid = (int)$p['id'];
    $shuffled_answers[$qid] = $new_correct_key;
    $shuffled_questions[$qid] = [
        'opcion_a' => $new_texts[0],
        'opcion_b' => $new_texts[1],
        'opcion_c' => $new_texts[2],
        'opcion_d' => $new_texts[3],
        'correct'  => $new_correct_key,
    ];

    return [
        'id'          => $qid,
        'pregunta'    => $p['pregunta'],
        'opcion_a'    => $new_texts[0],
        'opcion_b'    => $new_texts[1],
        'opcion_c'    => $new_texts[2],
        'opcion_d'    => $new_texts[3],
        'correct_key' => $new_correct_key,
        'explicacion' => $p['explicacion'],
    ];
}, $preguntas));

$_SESSION['shuffled_answers']   = $shuffled_answers;
$_SESSION['shuffled_questions'] = $shuffled_questions;

$config_json = json_encode([
    'moduloId'     => $modulo ? (int)$modulo : null,
    'modo'         => $modo,
    'totalSeconds' => 5400, // 90 min
]);
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?= htmlspecialchars($titulo) ?> - AWS Quiz</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<header class="header">
  <div class="header-inner">
    <a href="index.php" class="logo">
      <div class="logo-icon">☁</div>
      <div class="logo-text">AWS <span>Quiz</span></div>
    </a>
    <nav class="nav-links">
      <a href="index.php" class="nav-link">Inicio</a>
      <a href="chuleta.php" class="nav-link">Glosario AWS CLF-C02</a>
      <a href="test.php?modulo=6" class="nav-link">Azure AZ-900</a>
      <span class="nav-link disabled">Linux LPIC-1 <span class="nav-badge">Próximamente</span></span>
      <a href="admin.php" class="nav-link">Admin</a>
    </nav>
    <button id="soundToggle" class="sound-toggle" title="Activar sonido">🔇</button>
    <script>(function(){var b=document.getElementById('soundToggle'),u=function(){var on=localStorage.getItem('quiz_sound')==='on';b.textContent=on?'🔊':'🔇';b.title=on?'Desactivar sonido':'Activar sonido';};b.onclick=function(){localStorage.setItem('quiz_sound',localStorage.getItem('quiz_sound')==='on'?'off':'on');u();};u();}());</script>
  </div>
</header>

<div class="container">
  <div class="test-layout">

    <!-- MAIN AREA -->
    <div class="test-main">
      <div class="test-header-bar">
        <div>
          <div class="test-title"><?= htmlspecialchars($titulo) ?></div>
          <div class="test-subtitle"><?= count($preguntas) ?> preguntas · 90 minutos</div>
        </div>
        <button class="btn btn-danger" onclick="showModal('Salir del test','Perder\u00e1s tu progreso. \u00bfSeguro que deseas salir?',function(){location.href='index.php'})">
          <i class="fas fa-times"></i> Salir
        </button>
      </div>

      <!-- Question card will be rendered by JS -->
      <div id="questionCard" class="question-card">
        <div class="flex-center" style="padding:40px">
          <i class="fas fa-spinner fa-spin" style="font-size:2rem;color:#FF9900"></i>
        </div>
      </div>

      <div class="nav-buttons">
        <button id="btnPrev" class="btn btn-secondary" disabled>
          <i class="fas fa-arrow-left"></i> Anterior
        </button>
        <button id="btnSubmit" class="btn btn-success" disabled>
          <i class="fas fa-check"></i> Enviar Test
        </button>
        <button id="btnNext" class="btn btn-primary">
          Siguiente <i class="fas fa-arrow-right"></i>
        </button>
      </div>
    </div>

    <!-- SIDEBAR -->
    <div class="test-sidebar">
      <!-- Timer -->
      <div class="timer-box">
        <div class="timer-label"><i class="fas fa-clock"></i> Tiempo restante</div>
        <div class="timer-display" id="timerDisplay">01:30:00</div>
      </div>

      <!-- Progress -->
      <div class="progress-box">
        <div class="progress-label">
          <span>Progreso</span>
          <span id="progressLabel">0 / <?= count($preguntas) ?></span>
        </div>
        <div class="progress-bar-outer">
          <div class="progress-bar-inner" id="progressBar" style="width:0%"></div>
        </div>
      </div>

      <!-- Question Map -->
      <div class="q-map-box">
        <div class="q-map-title">Mapa de preguntas</div>
        <div class="q-map-grid" id="qMapGrid"></div>
      </div>
    </div>

  </div>
</div>

<!-- Modal -->
<div id="modalOverlay" class="modal-overlay">
  <div class="modal-box">
    <div class="modal-icon">❓</div>
    <div class="modal-title" id="modalTitle"></div>
    <div class="modal-body"  id="modalBody"></div>
    <div class="modal-actions">
      <button id="modalCancel" class="btn btn-secondary">Cancelar</button>
      <button id="modalConfirm" class="btn btn-primary">Confirmar</button>
    </div>
  </div>
</div>

<script>
window.QUIZ_DATA   = <?= $preguntas_json ?>;
window.QUIZ_CONFIG = <?= $config_json ?>;
</script>
<script src="js/quiz.js"></script>
</body>
</html>
