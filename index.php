<?php
require_once 'db/conexion.php';
session_start();

$db = getDB();

// Fetch modules with question counts
$modulos = $db->query("
    SELECT m.*, COUNT(p.id) as total_preguntas
    FROM modulos m
    LEFT JOIN preguntas p ON p.modulo_id = m.id
    GROUP BY m.id
    ORDER BY m.id
")->fetchAll();

// Recent results
$resultados = $db->query("
    SELECT r.*, m.nombre as modulo_nombre
    FROM resultados r
    LEFT JOIN modulos m ON m.id = r.modulo_id
    ORDER BY r.fecha DESC
    LIMIT 10
")->fetchAll();

$total_preguntas = $db->query("SELECT COUNT(*) FROM preguntas")->fetchColumn();
$total_tests     = $db->query("SELECT COUNT(*) FROM resultados")->fetchColumn();
$avg_score       = $db->query("SELECT AVG(correctas/total_preguntas*100) FROM resultados WHERE total_preguntas > 0")->fetchColumn();

$icons = ['fa-server','fa-database','fa-network-wired','fa-shield-alt','fa-dollar-sign'];
$icon_classes = ['icon-compute','icon-storage','icon-network','icon-security','icon-billing'];
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>AWS CLF-C02 Quiz - Práctica para Cloud Practitioner</title>
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
      <a href="index.php" class="nav-link active">Inicio</a>
      <a href="test.php?modo=completo" class="nav-link">Test Completo</a>
      <a href="chuleta.php" class="nav-link">Glosario AWS CLF-C02</a>
      <span class="nav-link disabled">Azure AZ-900 <span class="nav-badge">Próximamente</span></span>
      <span class="nav-link disabled">Linux LPIC-1 <span class="nav-badge">Próximamente</span></span>
      <a href="admin.php" class="nav-link">Admin</a>
    </nav>
    <button id="soundToggle" class="sound-toggle" title="Activar sonido">🔇</button>
    <script>(function(){var b=document.getElementById('soundToggle'),u=function(){var on=localStorage.getItem('quiz_sound')==='on';b.textContent=on?'🔊':'🔇';b.title=on?'Desactivar sonido':'Activar sonido';};b.onclick=function(){localStorage.setItem('quiz_sound',localStorage.getItem('quiz_sound')==='on'?'off':'on');u();};u();}());</script>
  </div>
</header>

<div class="hero">
  <h1>Practica para el examen<br><span>AWS Certified Cloud Practitioner</span></h1>
  <p>200 preguntas cubriendo todos los dominios del CLF-C02. Prepárate con confianza.</p>
  <div class="hero-stats">
    <div class="stat">
      <span class="stat-num"><?= $total_preguntas ?></span>
      <span class="stat-label">Preguntas</span>
    </div>
    <div class="stat">
      <span class="stat-num">5</span>
      <span class="stat-label">Módulos</span>
    </div>
    <div class="stat">
      <span class="stat-num">90'</span>
      <span class="stat-label">Tiempo</span>
    </div>
    <div class="stat">
      <span class="stat-num"><?= $total_tests ?></span>
      <span class="stat-label">Tests realizados</span>
    </div>
    <?php if ($avg_score): ?>
    <div class="stat">
      <span class="stat-num"><?= round($avg_score) ?>%</span>
      <span class="stat-label">Nota media</span>
    </div>
    <?php endif; ?>
  </div>
</div>

<div class="container">

  <!-- FULL TEST -->
  <div class="full-test-card">
    <div class="full-test-info">
      <h3><i class="fas fa-graduation-cap"></i> Test Completo CLF-C02</h3>
      <p><?= $total_preguntas ?> preguntas aleatorias · 90 minutos · Todos los módulos</p>
    </div>
    <div style="display:flex;gap:12px;flex-wrap:wrap">
      <a href="test.php?modo=completo" class="btn-full-test">
        <i class="fas fa-play"></i> Iniciar Test Completo
      </a>
      <a href="test.php?modo=repaso" class="btn-full-test" style="background:#37475A">
        <i class="fas fa-redo"></i> Modo Repaso
      </a>
    </div>
  </div>

  <!-- MODULES -->
  <h2 class="section-title">Test por Módulo</h2>
  <div class="modules-grid">
    <?php foreach ($modulos as $i => $m): ?>
    <div class="module-card">
      <div class="module-icon <?= $icon_classes[$i] ?? 'icon-compute' ?>">
        <i class="fas <?= htmlspecialchars($m['icono']) ?>"></i>
      </div>
      <div class="module-title"><?= htmlspecialchars($m['nombre']) ?></div>
      <div class="module-desc"><?= htmlspecialchars($m['descripcion']) ?></div>
      <div class="module-meta">
        <span class="module-count"><i class="fas fa-question-circle"></i> <?= $m['total_preguntas'] ?> preguntas</span>
        <a href="test.php?modulo=<?= $m['id'] ?>" class="btn-start">
          <i class="fas fa-play"></i> Empezar
        </a>
      </div>
    </div>
    <?php endforeach; ?>
  </div>

  <!-- HISTORY -->
  <?php if (!empty($resultados)): ?>
  <div class="history-section">
    <h2 class="section-title">Historial de Resultados</h2>
    <div class="history-table-wrap">
      <table class="history-table">
        <thead>
          <tr>
            <th>Fecha</th>
            <th>Módulo / Modo</th>
            <th>Puntuación</th>
            <th>Resultado</th>
            <th>Tiempo</th>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($resultados as $r):
            $pct   = $r['total_preguntas'] > 0 ? round($r['correctas']/$r['total_preguntas']*100) : 0;
            $pass  = $pct >= 70;
            $mins  = floor($r['tiempo_usado']/60);
            $secs  = $r['tiempo_usado'] % 60;
          ?>
          <tr>
            <td><?= date('d/m/Y H:i', strtotime($r['fecha'])) ?></td>
            <td><?= $r['modulo_nombre'] ? htmlspecialchars($r['modulo_nombre']) : ucfirst($r['modo']) ?></td>
            <td><strong><?= $r['correctas'] ?> / <?= $r['total_preguntas'] ?></strong> (<?= $pct ?>%)</td>
            <td><span class="badge <?= $pass ? 'badge-pass' : 'badge-fail' ?>"><?= $pass ? 'APROBADO' : 'SUSPENSO' ?></span></td>
            <td><?= sprintf('%02d:%02d', $mins, $secs) ?></td>
          </tr>
          <?php endforeach; ?>
        </tbody>
      </table>
    </div>
  </div>
  <?php endif; ?>

</div>

<div id="modalOverlay" class="modal-overlay">
  <div class="modal-box">
    <div class="modal-icon">❓</div>
    <div class="modal-title" id="modalTitle"></div>
    <div class="modal-body" id="modalBody"></div>
    <div class="modal-actions">
      <button id="modalCancel" class="btn btn-secondary" onclick="document.getElementById('modalOverlay').classList.remove('show')">Cancelar</button>
      <button id="modalConfirm" class="btn btn-primary">Confirmar</button>
    </div>
  </div>
</div>

<script src="js/quiz.js"></script>
</body>
</html>
