<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Snake Game with Score</title>
  <style>
    body {
      background: #000;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      height: 100vh;
      color: #0f0;
      font-family: monospace;
      margin: 0;
    }

    h1 {
      margin: 0;
    }

    #score {
      font-size: 24px;
      margin: 10px 0;
    }

    canvas {
      background-color: #111;
      border: 2px solid #0f0;
    }

    p {
      margin-top: 10px;
    }
  </style>
</head>
<body>

  <h1>🐍 Snake Game</h1>
  <div id="score">Score: 0</div>
  <canvas id="gameCanvas" width="400" height="400"></canvas>
  <p>Use arrow keys to move. Eat food, avoid walls and yourself!</p>

  <script>
    const canvas = document.getElementById('gameCanvas');
    const ctx = canvas.getContext('2d');
    const scoreDisplay = document.getElementById('score');

    const box = 20; // Size of one square
    const canvasSize = 400;
    const gridSize = canvasSize / box;

    let snake = [{ x: 9 * box, y: 9 * box }];
    let food = randomFoodPosition();
    let dx = box;
    let dy = 0;
    let score = 0;
    let gameInterval;

    function randomFoodPosition() {
      return {
        x: Math.floor(Math.random() * gridSize) * box,
        y: Math.floor(Math.random() * gridSize) * box
      };
    }

    document.addEventListener('keydown', changeDirection);

    function changeDirection(e) {
      if (e.key === 'ArrowLeft' && dx === 0) {
        dx = -box; dy = 0;
      } else if (e.key === 'ArrowRight' && dx === 0) {
        dx = box; dy = 0;
      } else if (e.key === 'ArrowUp' && dy === 0) {
        dx = 0; dy = -box;
      } else if (e.key === 'ArrowDown' && dy === 0) {
        dx = 0; dy = box;
      }
    }

    function draw() {
      ctx.clearRect(0, 0, canvas.width, canvas.height);

      // Draw snake
      snake.forEach((segment, index) => {
        ctx.fillStyle = index === 0 ? '#0f0' : '#070';
        ctx.fillRect(segment.x, segment.y, box, box);
        ctx.strokeStyle = '#000';
        ctx.strokeRect(segment.x, segment.y, box, box);
      });

      // Draw food
      ctx.fillStyle = 'red';
      ctx.fillRect(food.x, food.y, box, box);

      // Update score display
      scoreDisplay.textContent = 'Score: ' + score;
    }

    function update() {
      const head = { x: snake[0].x + dx, y: snake[0].y + dy };

      // Wall collision
      if (
        head.x < 0 || head.x >= canvas.width ||
        head.y < 0 || head.y >= canvas.height
      ) {
        gameOver();
        return;
      }

      // Self collision
      for (let i = 1; i < snake.length; i++) {
        if (head.x === snake[i].x && head.y === snake[i].y) {
          gameOver();
          return;
        }
      }

      snake.unshift(head);

      // Eat food
      if (head.x === food.x && head.y === food.y) {
        score += 10;
        food = randomFoodPosition();
      } else {
        snake.pop();
      }

      draw();
    }

    function gameOver() {
      clearInterval(gameInterval);
      alert('Game Over! Your score: ' + score);
      document.location.reload();
    }

    function startGame() {
      gameInterval = setInterval(update, 100);
    }

    draw();
    startGame();
  </script>

</body>
</html>
