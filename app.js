const http = require('http');
const port = 3000;

http.createServer((req, res) => {
  res.end('¡Hola desde Docker y Jenkins!');
}).listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}`);
});
