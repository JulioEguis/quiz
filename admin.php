<?php
require_once 'db/conexion.php';
session_start();

$db  = getDB();
$msg = '';
$err = '';

// Handle actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    if ($action === 'add_question') {
        $fields = ['modulo_id','pregunta','opcion_a','opcion_b','opcion_c','opcion_d','respuesta_correcta','explicacion','dificultad'];
        $data   = [];
        foreach ($fields as $f) {
            $data[$f] = trim($_POST[$f] ?? '');
        }
        if (in_array('', $data)) {
            $err = 'Por favor completa todos los campos.';
        } elseif (!in_array($data['respuesta_correcta'], ['A','B','C','D'])) {
            $err = 'La respuesta correcta debe ser A, B, C o D.';
        } else {
            $stmt = $db->prepare("INSERT INTO preguntas (modulo_id,pregunta,opcion_a,opcion_b,opcion_c,opcion_d,respuesta_correcta,explicacion,dificultad) VALUES (?,?,?,?,?,?,?,?,?)");
            $stmt->execute(array_values($data));
            $msg = '✓ Pregunta añadida correctamente.';
        }
    } elseif ($action === 'delete_question') {
        $id = (int)($_POST['pregunta_id'] ?? 0);
        if ($id > 0) {
            $db->prepare("DELETE FROM respuestas_detalle WHERE pregunta_id = ?")->execute([$id]);
            $db->prepare("DELETE FROM preguntas WHERE id = ?")->execute([$id]);
            $msg = '✓ Pregunta eliminada.';
        }
    } elseif ($action === 'clear_history') {
        $db->exec("DELETE FROM respuestas_detalle");
        $db->exec("DELETE FROM resultados");
        $msg = '✓ Historial borrado.';
    }
}

// Fetch data
$modulos   = $db->query("SELECT * FROM modulos ORDER BY id")->fetchAll();
$preguntas = $db->query("
    SELECT p.*, m.nombre as modulo_nombre
    FROM preguntas p
    JOIN modulos m ON m.id = p.modulo_id
    ORDER BY p.id DESC
    LIMIT 100
")->fetchAll();
$total_preguntas = $db->query("SELECT COUNT(*) FROM preguntas")->fetchColumn();
$total_resultados= $db->query("SELECT COUNT(*) FROM resultados")->fetchColumn();

$filter_mod = $_GET['mod'] ?? '';
if ($filter_mod) {
    $stmt2 = $db->prepare("
        SELECT p.*, m.nombre as modulo_nombre
        FROM preguntas p
        JOIN modulos m ON m.id = p.modulo_id
        WHERE p.modulo_id = ?
        ORDER BY p.id DESC
    ");
    $stmt2->execute([$filter_mod]);
    $preguntas = $stmt2->fetchAll();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin - AWS Quiz</title>
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
      <a href="test.php?modo=completo" class="nav-link">Test</a>
      <a href="chuleta.php" class="nav-link">Glosario AWS CLF-C02</a>
      <a href="test.php?modulo=6" class="nav-link">Azure AZ-900</a>
      <span class="nav-link disabled">Linux LPIC-1 <span class="nav-badge">Próximamente</span></span>
      <a href="admin.php" class="nav-link active">Admin</a>
    </nav>
    <button id="soundToggle" class="sound-toggle" title="Activar sonido">🔇</button>
    <script>(function(){var b=document.getElementById('soundToggle'),u=function(){var on=localStorage.getItem('quiz_sound')==='on';b.textContent=on?'🔊':'🔇';b.title=on?'Desactivar sonido':'Activar sonido';};b.onclick=function(){localStorage.setItem('quiz_sound',localStorage.getItem('quiz_sound')==='on'?'off':'on');u();};u();}());</script>
  </div>
</header>

<div class="container">
  <h1 class="section-title">Panel de Administración</h1>

  <?php if ($msg): ?>
  <div class="alert alert-success"><i class="fas fa-check-circle"></i> <?= htmlspecialchars($msg) ?></div>
  <?php endif; ?>
  <?php if ($err): ?>
  <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> <?= htmlspecialchars($err) ?></div>
  <?php endif; ?>

  <!-- STATS -->
  <div style="display:flex;gap:16px;flex-wrap:wrap;margin-bottom:28px">
    <div class="form-card" style="flex:1;min-width:160px;text-align:center">
      <div style="font-size:2.5rem;font-weight:800;color:#FF9900"><?= $total_preguntas ?></div>
      <div style="color:#616161;font-size:0.85rem;text-transform:uppercase">Preguntas</div>
    </div>
    <div class="form-card" style="flex:1;min-width:160px;text-align:center">
      <div style="font-size:2.5rem;font-weight:800;color:#1A73E8"><?= $total_resultados ?></div>
      <div style="color:#616161;font-size:0.85rem;text-transform:uppercase">Tests realizados</div>
    </div>
    <div class="form-card" style="flex:1;min-width:160px;text-align:center">
      <div style="font-size:2.5rem;font-weight:800;color:#1DB954"><?= count($modulos) ?></div>
      <div style="color:#616161;font-size:0.85rem;text-transform:uppercase">Módulos</div>
    </div>
  </div>

  <div class="admin-grid">

    <!-- ADD QUESTION FORM -->
    <div>
      <div class="form-card">
        <div class="form-title"><i class="fas fa-plus-circle" style="color:#FF9900"></i> Añadir Pregunta</div>
        <form method="POST" action="admin.php">
          <input type="hidden" name="action" value="add_question">

          <div class="form-group">
            <label class="form-label">Módulo</label>
            <select name="modulo_id" class="form-control" required>
              <option value="">Selecciona un módulo</option>
              <?php foreach ($modulos as $m): ?>
              <option value="<?= $m['id'] ?>"><?= htmlspecialchars($m['nombre']) ?></option>
              <?php endforeach; ?>
            </select>
          </div>

          <div class="form-group">
            <label class="form-label">Pregunta</label>
            <textarea name="pregunta" class="form-control" rows="3" required placeholder="Escribe la pregunta aquí..."></textarea>
          </div>

          <div class="form-group">
            <label class="form-label">Opciones de respuesta</label>
            <div class="options-inputs">
              <?php foreach (['A','B','C','D'] as $opt): ?>
              <div class="option-input-row">
                <div class="option-input-letter"><?= $opt ?></div>
                <input type="text" name="opcion_<?= strtolower($opt) ?>" class="form-control"
                       placeholder="Opción <?= $opt ?>" required>
              </div>
              <?php endforeach; ?>
            </div>
          </div>

          <div class="form-group">
            <label class="form-label">Respuesta Correcta</label>
            <select name="respuesta_correcta" class="form-control" required>
              <option value="">Selecciona</option>
              <option value="A">A</option>
              <option value="B">B</option>
              <option value="C">C</option>
              <option value="D">D</option>
            </select>
          </div>

          <div class="form-group">
            <label class="form-label">Explicación</label>
            <textarea name="explicacion" class="form-control" rows="4" required
                      placeholder="Explica por qué esta es la respuesta correcta..."></textarea>
          </div>

          <div class="form-group">
            <label class="form-label">Dificultad</label>
            <select name="dificultad" class="form-control">
              <option value="facil">Fácil</option>
              <option value="medio" selected>Medio</option>
              <option value="dificil">Difícil</option>
            </select>
          </div>

          <button type="submit" class="btn btn-primary" style="width:100%">
            <i class="fas fa-plus"></i> Añadir Pregunta
          </button>
        </form>
      </div>

      <!-- DANGER ZONE -->
      <div class="form-card mt-2" style="border:2px solid #FFCDD2">
        <div class="form-title" style="color:#C62828"><i class="fas fa-exclamation-triangle"></i> Zona de peligro</div>
        <form method="POST" onsubmit="return confirm('¿Seguro? Esta acción no se puede deshacer.')">
          <input type="hidden" name="action" value="clear_history">
          <p style="font-size:0.88rem;color:#616161;margin-bottom:16px">Eliminar todo el historial de tests realizados.</p>
          <button type="submit" class="btn btn-danger">
            <i class="fas fa-trash"></i> Borrar Historial
          </button>
        </form>
      </div>
    </div>

    <!-- QUESTIONS LIST -->
    <div>
      <div class="form-card">
        <div class="form-title" style="display:flex;justify-content:space-between;align-items:center">
          <span><i class="fas fa-list" style="color:#FF9900"></i> Preguntas (<?= $total_preguntas ?> total)</span>
        </div>

        <!-- Filter by module -->
        <div style="display:flex;gap:8px;flex-wrap:wrap;margin-bottom:16px">
          <a href="admin.php" class="btn btn-secondary" style="font-size:0.8rem;padding:5px 12px <?= !$filter_mod ? ';background:#FF9900;color:#fff;border-color:#FF9900' : '' ?>">Todas</a>
          <?php foreach ($modulos as $m): ?>
          <a href="admin.php?mod=<?= $m['id'] ?>" class="btn btn-secondary"
             style="font-size:0.8rem;padding:5px 12px<?= $filter_mod == $m['id'] ? ';background:#FF9900;color:#fff;border-color:#FF9900' : '' ?>">
            <?= htmlspecialchars(explode(' ', $m['nombre'])[0]) ?>
          </a>
          <?php endforeach; ?>
        </div>

        <div style="max-height:600px;overflow-y:auto">
          <?php if (empty($preguntas)): ?>
          <div class="alert alert-info">No hay preguntas en este módulo.</div>
          <?php endif; ?>
          <?php foreach ($preguntas as $p): ?>
          <div style="border:1px solid #E0E0E0;border-radius:8px;padding:14px;margin-bottom:10px">
            <div style="display:flex;justify-content:space-between;align-items:flex-start;gap:8px;margin-bottom:8px">
              <span class="badge badge-info" style="white-space:nowrap">#<?= $p['id'] ?></span>
              <span class="badge" style="background:#FFF3E0;color:#E65100;white-space:nowrap">
                <?= htmlspecialchars(explode(' ', $p['modulo_nombre'])[0]) ?>
              </span>
              <span class="badge" style="background:#F5F5F5;color:#616161;white-space:nowrap">
                <?= $p['dificultad'] ?>
              </span>
              <form method="POST" style="margin-left:auto" onsubmit="return confirm('¿Eliminar esta pregunta?')">
                <input type="hidden" name="action" value="delete_question">
                <input type="hidden" name="pregunta_id" value="<?= $p['id'] ?>">
                <button type="submit" class="btn" style="background:none;color:#C62828;padding:4px 8px;font-size:0.8rem">
                  <i class="fas fa-trash"></i>
                </button>
              </form>
            </div>
            <div style="font-size:0.88rem;color:#212121;line-height:1.4;margin-bottom:8px">
              <?= htmlspecialchars(mb_substr($p['pregunta'], 0, 120)) ?><?= mb_strlen($p['pregunta']) > 120 ? '...' : '' ?>
            </div>
            <div style="font-size:0.78rem;color:#616161">
              Correcta: <strong style="color:#2E7D32"><?= $p['respuesta_correcta'] ?></strong>
            </div>
          </div>
          <?php endforeach; ?>
          <?php if (count($preguntas) === 100 && !$filter_mod): ?>
          <div class="alert alert-info">Mostrando las últimas 100 preguntas. Filtra por módulo para ver todas.</div>
          <?php endif; ?>
        </div>
      </div>
    </div>

  </div>
</div>

<script src="js/quiz.js"></script>
</body>
</html>
