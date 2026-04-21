// AWS Quiz - Main JavaScript
'use strict';

// ─── SOUND SYSTEM ────────────────────────────────────────────────────────────
const SoundSystem = {
  get enabled() { return localStorage.getItem('quiz_sound') === 'on'; },

  _ctx() {
    try { return new (window.AudioContext || window.webkitAudioContext)(); } catch(e) { return null; }
  },

  correct() {
    if (!this.enabled) return;
    const ctx = this._ctx(); if (!ctx) return;
    [[523, 0], [659, 0.1], [784, 0.18]].forEach(([freq, t]) => {
      const osc = ctx.createOscillator(), gain = ctx.createGain();
      osc.connect(gain); gain.connect(ctx.destination);
      osc.type = 'sine'; osc.frequency.value = freq;
      gain.gain.setValueAtTime(0.22, ctx.currentTime + t);
      gain.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + t + 0.18);
      osc.start(ctx.currentTime + t);
      osc.stop(ctx.currentTime + t + 0.2);
    });
  },

  wrong() {
    if (!this.enabled) return;
    const ctx = this._ctx(); if (!ctx) return;
    [[280, 0], [220, 0.16]].forEach(([freq, t]) => {
      const osc = ctx.createOscillator(), gain = ctx.createGain();
      osc.connect(gain); gain.connect(ctx.destination);
      osc.type = 'sawtooth'; osc.frequency.value = freq;
      gain.gain.setValueAtTime(0.18, ctx.currentTime + t);
      gain.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + t + 0.22);
      osc.start(ctx.currentTime + t);
      osc.stop(ctx.currentTime + t + 0.25);
    });
  }
};

// ─── TIMER ──────────────────────────────────────────────────────────────────
class QuizTimer {
  constructor(totalSeconds, onTick, onExpire) {
    this.remaining = totalSeconds;
    this.onTick    = onTick;
    this.onExpire  = onExpire;
    this.interval  = null;
  }

  start() {
    this.onTick(this.remaining);
    this.interval = setInterval(() => {
      this.remaining--;
      this.onTick(this.remaining);
      if (this.remaining <= 0) {
        this.stop();
        this.onExpire();
      }
    }, 1000);
  }

  stop() { clearInterval(this.interval); this.interval = null; }

  getElapsed(total) { return total - this.remaining; }

  static format(seconds) {
    const h = Math.floor(seconds / 3600);
    const m = Math.floor((seconds % 3600) / 60);
    const s = seconds % 60;
    return [
      h > 0 ? String(h).padStart(2, '0') : null,
      String(m).padStart(2, '0'),
      String(s).padStart(2, '0')
    ].filter(Boolean).join(':');
  }
}

// ─── QUIZ ENGINE ─────────────────────────────────────────────────────────────
class QuizEngine {
  constructor(config) {
    this.questions  = config.questions || [];
    this.currentIdx = 0;
    this.answers    = {};        // { qid: 'A'|'B'|'C'|'D' }
    this.results    = {};        // { qid: { correct: bool } }
    this.answered   = new Set(); // set of answered qids
    this.totalTime  = config.totalSeconds || 5400;
    this.timer      = null;
    this.submitted  = false;
    this.startedAt  = Date.now();

    this._bindElements();
    this._initTimer();
    this._renderQuestion();
    this._renderMap();
  }

  _bindElements() {
    this.timerEl     = document.getElementById('timerDisplay');
    this.progressEl  = document.getElementById('progressBar');
    this.progressLbl = document.getElementById('progressLabel');
    this.questionEl  = document.getElementById('questionCard');
    this.prevBtn     = document.getElementById('btnPrev');
    this.nextBtn     = document.getElementById('btnNext');
    this.submitBtn   = document.getElementById('btnSubmit');
    this.mapGrid     = document.getElementById('qMapGrid');

    if (this.prevBtn)   this.prevBtn.addEventListener('click',   () => this._navigate(-1));
    if (this.nextBtn)   this.nextBtn.addEventListener('click',   () => this._navigate(1));
    if (this.submitBtn) this.submitBtn.addEventListener('click', () => this._confirmSubmit());
  }

  _initTimer() {
    this.timer = new QuizTimer(
      this.totalTime,
      (remaining) => {
        if (!this.timerEl) return;
        this.timerEl.textContent = QuizTimer.format(remaining);
        if (remaining <= 300) this.timerEl.classList.add('warning');
        else                  this.timerEl.classList.remove('warning');
      },
      () => this._autoSubmit()
    );
    this.timer.start();
  }

  _renderQuestion() {
    const q = this.questions[this.currentIdx];
    if (!q || !this.questionEl) return;

    const total      = this.questions.length;
    const answered   = this.answered.size;
    const pct        = Math.round((answered / total) * 100);
    const hasAnswered = this.answered.has(q.id);
    const userAnswer  = this.answers[q.id] || null;
    const correctKey  = q.correct_key || null;

    // Progress
    if (this.progressEl)  this.progressEl.style.width = pct + '%';
    if (this.progressLbl) this.progressLbl.textContent = `${answered} / ${total} respondidas`;

    // Nav buttons
    if (this.prevBtn)   this.prevBtn.disabled  = this.currentIdx === 0;
    if (this.nextBtn)   this.nextBtn.disabled  = this.currentIdx === total - 1;
    if (this.submitBtn) this.submitBtn.disabled = answered < 1;

    // Build options HTML
    const opts = [
      { key: 'A', text: q.opcion_a },
      { key: 'B', text: q.opcion_b },
      { key: 'C', text: q.opcion_c },
      { key: 'D', text: q.opcion_d },
    ];

    let optionsHtml = '';
    opts.forEach(o => {
      let cls  = '';
      let icon = '';

      if (hasAnswered) {
        if (o.key === correctKey) {
          cls  = 'correct';
          icon = '<span style="margin-left:auto;color:#2E7D32"><i class="fas fa-check-circle"></i></span>';
        } else if (o.key === userAnswer) {
          cls  = 'incorrect';
          icon = '<span style="margin-left:auto;color:#C62828"><i class="fas fa-times-circle"></i></span>';
        } else {
          cls = 'disabled';
        }
      } else {
        if (userAnswer === o.key) cls = 'selected';
      }

      const click = hasAnswered ? '' : `onclick="quizEngine._selectAnswer('${o.key}')"`;
      optionsHtml += `
        <div class="option-item ${cls}" data-key="${o.key}" ${click}>
          <div class="option-letter">${o.key}</div>
          <div class="option-text">${this._escHtml(o.text)}</div>
          ${icon}
        </div>`;
    });

    // Feedback panel (shown after answering)
    let feedbackHtml = '';
    if (hasAnswered && correctKey) {
      const result    = this.results[q.id];
      const isCorrect = result && result.correct;
      const cls       = isCorrect ? 'feedback-correct' : 'feedback-wrong';
      const icon      = isCorrect
        ? '<i class="fas fa-check-circle"></i> ¡Correcto!'
        : '<i class="fas fa-times-circle"></i> Incorrecto';
      const exp = q.explicacion ? this._escHtml(q.explicacion) : '';
      feedbackHtml = `
        <div class="feedback-panel ${cls}">
          <div class="feedback-header">${icon}</div>
          ${exp ? `<p class="feedback-exp">${exp}</p>` : ''}
        </div>`;
    }

    this.questionEl.innerHTML = `
      <div class="question-num">Pregunta ${this.currentIdx + 1} de ${total}</div>
      <div class="question-text">${this._escHtml(q.pregunta)}</div>
      <div class="options-list">${optionsHtml}</div>
      ${feedbackHtml}
    `;

    this._updateMap();
  }

  _selectAnswer(key) {
    const q = this.questions[this.currentIdx];
    if (!q || this.submitted) return;
    if (this.answered.has(q.id)) return; // already answered

    this.answers[q.id] = key;
    this.answered.add(q.id);

    const isCorrect = q.correct_key ? (key === q.correct_key) : true;
    this.results[q.id] = { correct: isCorrect, userAnswer: key };

    if (isCorrect) SoundSystem.correct(); else SoundSystem.wrong();

    this._renderQuestion(); // re-render with feedback
  }

  _navigate(dir) {
    const next = this.currentIdx + dir;
    if (next < 0 || next >= this.questions.length) return;
    this.currentIdx = next;
    this._renderQuestion();
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  _renderMap() {
    if (!this.mapGrid) return;
    this.mapGrid.innerHTML = this.questions.map((q, i) => {
      let cls = '';
      if (i === this.currentIdx) cls += ' current';
      if (this.results[q.id] !== undefined) {
        cls += this.results[q.id].correct ? ' correct' : ' wrong';
      } else if (this.answered.has(q.id)) {
        cls += ' answered';
      }
      return `<div class="q-map-dot${cls}" title="Pregunta ${i + 1}" onclick="quizEngine._jumpTo(${i})">${i + 1}</div>`;
    }).join('');
  }

  _updateMap() { this._renderMap(); }

  _jumpTo(idx) {
    this.currentIdx = idx;
    this._renderQuestion();
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  _confirmSubmit() {
    const answered   = this.answered.size;
    const total      = this.questions.length;
    const unanswered = total - answered;
    const msg = unanswered > 0
      ? `Tienes ${unanswered} pregunta(s) sin responder. ¿Deseas enviar el test de todas formas?`
      : '¿Estás seguro de que deseas enviar el test?';
    showModal('¿Enviar test?', msg, () => this._submit());
  }

  _autoSubmit() {
    showModal('⏰ Tiempo agotado', 'El tiempo se ha agotado. El test se enviará automáticamente.', () => this._submit(), true);
  }

  _submit() {
  if (this.submitted) return;
  this.submitted = true;

  if (this.timer) this.timer.stop();

  const elapsed = Math.round((Date.now() - this.startedAt) / 1000);

  const form = document.createElement('form');
  form.method = 'POST';
  form.action = 'resultado.php';

  const addField = (name, value) => {
    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = name;
    input.value = value;
    form.appendChild(input);
  };

  addField('tiempo_usado', elapsed);
  addField('modulo_id', window.QUIZ_CONFIG?.moduloId || '');
  addField('modo', window.QUIZ_CONFIG?.modo || 'completo');
  addField('answers_json', JSON.stringify(this.answers));
  addField('question_ids', JSON.stringify(this.questions.map(q => q.id)));

  document.body.appendChild(form);

  console.log("ENVIANDO TEST..."); // 👈 DEBUG

  form.submit();
}

  _escHtml(str) {
    return String(str)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;');
  }
}

// ─── MODAL ────────────────────────────────────────────────────────────────────
function showModal(title, body, onConfirm, autoConfirm = false) {
  const overlay = document.getElementById('modalOverlay');
  if (!overlay) { if (onConfirm) onConfirm(); return; }

  document.getElementById('modalTitle').textContent = title;
  document.getElementById('modalBody').textContent  = body;

  const confirmBtn = document.getElementById('modalConfirm');
  const cancelBtn  = document.getElementById('modalCancel');

  if (cancelBtn) cancelBtn.style.display = autoConfirm ? 'none' : '';

  const cleanup = () => overlay.classList.remove('show');

  confirmBtn.onclick = () => { cleanup(); if (onConfirm) onConfirm(); };
  if (cancelBtn) cancelBtn.onclick = cleanup;

  overlay.classList.add('show');

  if (autoConfirm) setTimeout(() => { cleanup(); if (onConfirm) onConfirm(); }, 3000);
}

// ─── RESULTS PAGE: TOGGLE EXPLANATION ─────────────────────────────────────────
function toggleExplanation(btn, boxId) {
  const box = document.getElementById(boxId);
  if (!box) return;
  const isOpen = box.classList.toggle('show');
  btn.textContent = isOpen ? 'Ocultar explicación' : 'Ver explicación';
}

// ─── INIT ─────────────────────────────────────────────────────────────────────
let quizEngine = null;

document.addEventListener('DOMContentLoaded', () => {
  if (typeof window.QUIZ_DATA !== 'undefined' && window.QUIZ_DATA.length > 0) {
    quizEngine = new QuizEngine({
      questions:    window.QUIZ_DATA,
      totalSeconds: window.QUIZ_CONFIG?.totalSeconds || 5400,
    });
  }

  // Highlight active nav link
  document.querySelectorAll('.nav-link').forEach(l => {
    if (l.href === location.href) l.classList.add('active');
  });
});
