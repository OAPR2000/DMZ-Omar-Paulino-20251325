<?php
mysqli_report(MYSQLI_REPORT_OFF);
echo "<h1>Sistema de Caja - Lab 2025-1325</h1>";
$c = new mysqli("10.13.25.146", "webuser", "Web1325!Pass", "tienda");
if ($c->connect_error) { die("Error DB: " . $c->connect_error); }
$r = $c->query("SELECT nombre, precio FROM productos");
echo "<table border='1'><tr><th>Producto</th><th>Precio</th></tr>";
while ($f = $r->fetch_assoc()) {
  echo "<tr><td>" . htmlspecialchars($f['nombre']) . "</td><td>" . $f['precio'] . "</td></tr>";
}
echo "</table>";
