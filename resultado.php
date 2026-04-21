<?php
require_once 'db/conexion.php';
session_start();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: index.php');
    exit;
}

$db = getDB();

// Validate session
if (empty($_SESSION['quiz_preguntas'])) {
    header('Location: index.php');
    exit;
}

// Get data from POST
$answers_json  = $_POST['answers_json']   ?? '{}';
$question_ids  = json_decode($_POST['question_ids'] ?? '[]', true);
$tiempo_usado  = max(0, (int)($_POST['tiempo_usado'] ?? 0));
$modulo_id     = !empty($_POST['modulo_id']) ? (int)$_POST['modulo_id'] : null;
$modo          = preg_replace('/[^a-z_]/', '', $_POST['modo'] ?? 'completo');
$answers       = json_decode($answers_json, true) ?: [];

// Only use question_ids that were in the session
$valid_ids = $_SESSION['quiz_preguntas'];

// Fetch question details (answer keys + explanations)
if (empty($question_ids)) {
    $question_ids = $valid_ids;
}

$placeholders = implode(',', array_fill(0, count($question_ids), '?'));
$stmt = $db->prepare("SELECT * FROM preguntas WHERE id IN ($placeholders)");
$stmt->execute($question_ids);
$preguntas_map = [];
foreach ($stmt->fetchAll() as $p) {
    $preguntas_map[$p['id']] = $p;
}

// Use shuffled answer mapping from session (set in test.php)
$shuffled_answers   = $_SESSION['shuffled_answers']   ?? [];
$shuffled_questions = $_SESSION['shuffled_questions'] ?? [];

// Score
$correctas = 0;
$detalles  = [];

foreach ($question_ids as $qid) {
    $qid = (int)$qid;
    if (!isset($preguntas_map[$qid])) continue;
    $p = $preguntas_map[$qid];

    // Determine correct answer: use shuffled version if available
    $shuffled_q   = $shuffled_questions[$qid] ?? null;
    $correct_key  = $shuffled_q ? $shuffled_q['correct'] : $p['respuesta_correcta'];

    $user_ans   = $answers[$qid] ?? null;
    $is_correct = $user_ans === $correct_key;
    if ($is_correct) $correctas++;

    // Use shuffled option texts if available (so review matches what user saw)
    $detalles[] = [
        'pregunta_id'       => $qid,
        'pregunta'          => $p['pregunta'],
        'opcion_a'          => $shuffled_q ? $shuffled_q['opcion_a'] : $p['opcion_a'],
        'opcion_b'          => $shuffled_q ? $shuffled_q['opcion_b'] : $p['opcion_b'],
        'opcion_c'          => $shuffled_q ? $shuffled_q['opcion_c'] : $p['opcion_c'],
        'opcion_d'          => $shuffled_q ? $shuffled_q['opcion_d'] : $p['opcion_d'],
        'respuesta_correcta'=> $correct_key,
        'respuesta_dada'    => $user_ans,
        'es_correcta'       => $is_correct,
        'explicacion'       => $p['explicacion'],
    ];
}

$total = count($detalles);
$pct   = $total > 0 ? round($correctas / $total * 100) : 0;
$pass  = $pct >= 70;

// Save to DB
$sesion_id = session_id();
$stmt = $db->prepare("
    INSERT INTO resultados (sesion_id, modulo_id, modo, total_preguntas, correctas, tiempo_usado)
    VALUES (?, ?, ?, ?, ?, ?)
");
$stmt->execute([$sesion_id, $modulo_id, $modo, $total, $correctas, $tiempo_usado]);
$resultado_id = $db->lastInsertId();

// Save detail
$stmt2 = $db->prepare("INSERT INTO respuestas_detalle (resultado_id, pregunta_id, respuesta_dada, es_correcta) VALUES (?,?,?,?)");
foreach ($detalles as $d) {
    $stmt2->execute([$resultado_id, $d['pregunta_id'], $d['respuesta_dada'], $d['es_correcta'] ? 1 : 0]);
}

// Clear session quiz data
unset($_SESSION['quiz_preguntas'], $_SESSION['quiz_start']);

$mins = floor($tiempo_usado / 60);
$secs = $tiempo_usado % 60;
$tiempo_str = sprintf('%02d:%02d', $mins, $secs);

$incorrectas = $total - $correctas;
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Resultado - AWS Quiz</title>
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
      <a href="test.php?modo=completo" class="nav-link">Nuevo Test</a>
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

  <!-- RESULTS HERO -->
  <div class="results-hero">
    <div class="score-circle <?= $pass ? 'pass' : 'fail' ?>">
      <div class="score-pct"><?= $pct ?>%</div>
      <div class="score-sub"><?= $pass ? 'APROBADO' : 'SUSPENSO' ?></div>
    </div>
    <h2 style="font-size:1.6rem;margin-bottom:8px">
      <?= $pass ? '¡Enhorabuena! Has superado el test' : 'Sigue practicando, ¡lo conseguirás!' ?>
    </h2>
    <p style="color:#aaa;margin-bottom:20px">Puntuación mínima para aprobar: 70%</p>
    <div class="results-stats">
      <div class="r-stat">
        <div class="r-stat-num text-green"><?= $correctas ?></div>
        <div class="r-stat-label">Correctas</div>
      </div>
      <div class="r-stat">
        <div class="r-stat-num text-red"><?= $incorrectas ?></div>
        <div class="r-stat-label">Incorrectas</div>
      </div>
      <div class="r-stat">
        <div class="r-stat-num"><?= $total ?></div>
        <div class="r-stat-label">Total</div>
      </div>
      <div class="r-stat">
        <div class="r-stat-num text-orange"><?= $tiempo_str ?></div>
        <div class="r-stat-label">Tiempo</div>
      </div>
    </div>
  </div>

  <!-- ACTIONS -->
  <div style="display:flex;gap:12px;flex-wrap:wrap;margin-bottom:30px;justify-content:center">
    <a href="index.php" class="btn btn-secondary"><i class="fas fa-home"></i> Inicio</a>
    <a href="test.php?modo=completo" class="btn btn-primary"><i class="fas fa-redo"></i> Nuevo Test Completo</a>
    <?php if ($modulo_id): ?>
    <a href="test.php?modulo=<?= $modulo_id ?>" class="btn btn-primary"><i class="fas fa-redo"></i> Repetir Módulo</a>
    <?php endif; ?>
    <?php if ($incorrectas > 0): ?>
    <a href="test.php?modo=repaso" class="btn btn-secondary" style="background:#37475A;color:#fff;border:none">
      <i class="fas fa-book"></i> Repasar Falladas
    </a>
    <?php endif; ?>
  </div>

  <!-- FILTER -->
  <div style="display:flex;gap:10px;margin-bottom:20px;flex-wrap:wrap;align-items:center">
    <h2 class="section-title" style="margin-bottom:0">Revisión de Respuestas</h2>
    <div style="margin-left:auto;display:flex;gap:8px">
      <button class="btn btn-secondary" onclick="filterReview('all')"    id="filterAll">Todas</button>
      <button class="btn btn-secondary" onclick="filterReview('wrong')"  id="filterWrong" style="color:#C62828">Incorrectas</button>
      <button class="btn btn-secondary" onclick="filterReview('correct')" id="filterCorrect" style="color:#2E7D32">Correctas</button>
    </div>
  </div>

  <!-- REVIEW CARDS -->
  <div id="reviewContainer">
    <?php foreach ($detalles as $i => $d):
      $opts = [
          'A' => $d['opcion_a'],
          'B' => $d['opcion_b'],
          'C' => $d['opcion_c'],
          'D' => $d['opcion_d'],
      ];
      $correct_class = $d['es_correcta'] ? 'correct-card' : 'incorrect-card';
    ?>
    <div class="review-card <?= $correct_class ?>" data-correct="<?= $d['es_correcta'] ? '1' : '0' ?>">
      <div class="review-q-num">
        Pregunta <?= $i + 1 ?>
        <?php if ($d['es_correcta']): ?>
          <span class="badge badge-pass"><i class="fas fa-check"></i> Correcta</span>
        <?php else: ?>
          <span class="badge badge-fail"><i class="fas fa-times"></i> Incorrecta</span>
        <?php endif; ?>
      </div>
      <div class="review-q-text"><?= htmlspecialchars($d['pregunta']) ?></div>

      <div class="review-answers">
        <?php foreach ($opts as $key => $text): ?>
          <?php
            $cls = 'neutral';
            if ($key === $d['respuesta_correcta']) $cls = 'correct-ans';
            elseif ($key === $d['respuesta_dada'] && !$d['es_correcta']) $cls = 'incorrect-ans';
          ?>
          <div class="review-answer-item <?= $cls ?>">
            <?php if ($key === $d['respuesta_correcta']): ?>
              <i class="fas fa-check-circle"></i>
            <?php elseif ($key === $d['respuesta_dada'] && !$d['es_correcta']): ?>
              <i class="fas fa-times-circle"></i>
            <?php else: ?>
              <i class="fas fa-circle" style="opacity:0.3"></i>
            <?php endif; ?>
            <strong><?= $key ?>.</strong> <?= htmlspecialchars($text) ?>
            <?php if ($key === $d['respuesta_correcta']): ?>
              <span class="small" style="margin-left:auto;opacity:0.7">(Correcta)</span>
            <?php endif; ?>
            <?php if ($key === $d['respuesta_dada'] && !$d['es_correcta']): ?>
              <span class="small" style="margin-left:auto;opacity:0.7">(Tu respuesta)</span>
            <?php endif; ?>
          </div>
        <?php endforeach; ?>
        <?php if (empty($d['respuesta_dada'])): ?>
          <div class="review-answer-item" style="background:#FFF8F0;color:#E65100">
            <i class="fas fa-exclamation-circle"></i> Sin responder
          </div>
        <?php endif; ?>
      </div>

      <button class="btn btn-secondary" style="font-size:0.82rem;padding:6px 14px"
              onclick="toggleExplanation(this, 'exp_<?= $d['pregunta_id'] ?>')">
        Ver explicación
      </button>
      <div id="exp_<?= $d['pregunta_id'] ?>" class="explanation-box">
        <div class="explanation-title"><i class="fas fa-lightbulb"></i> Explicación</div>
        <div class="explanation-text"><?= htmlspecialchars($d['explicacion']) ?></div>
      </div>
    </div>
    <?php endforeach; ?>
  </div>

</div>

<script src="js/quiz.js"></script>
<script>
function filterReview(type) {
  document.querySelectorAll('.review-card').forEach(card => {
    const isCorrect = card.dataset.correct === '1';
    if (type === 'all')     card.style.display = '';
    else if (type === 'wrong')   card.style.display = isCorrect ? 'none' : '';
    else if (type === 'correct') card.style.display = isCorrect ? '' : 'none';
  });
  ['filterAll','filterWrong','filterCorrect'].forEach(id => {
    document.getElementById(id)?.classList.remove('btn-primary');
    document.getElementById(id)?.classList.add('btn-secondary');
  });
  const activeId = type === 'all' ? 'filterAll' : (type === 'wrong' ? 'filterWrong' : 'filterCorrect');
  document.getElementById(activeId)?.classList.replace('btn-secondary','btn-primary');
}
</script>
</body>
</html>
