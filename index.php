<?php
// Fortam PHP sa ne arate explicit orice eroare de conexiune sau de SQL
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

// Preluam datele din "seiful" sistemului de operare (fara parole in clar)
$servername = $_SERVER['DB_ENDPOINT'] ?? getenv('DB_ENDPOINT');
$username   = $_SERVER['DB_USER'] ?? getenv('DB_USER');
$password   = $_SERVER['DB_PASS'] ?? getenv('DB_PASS');
$dbname     = $_SERVER['DB_NAME'] ?? getenv('DB_NAME');

try {
    // Incercam conexiunea la RDS
    $conn = new mysqli($servername, $username, $password, $dbname);
    
    echo "<h1>Panoul de Control (Versiunea Securizata)</h1>";

    // Extragem datele din tabelul creat anterior
    $sql = "SELECT id, nume, functie FROM angajati";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        echo "<table border='1' cellpadding='10' style='border-collapse: collapse; text-align: left;'>";
        echo "<tr style='background-color: #f2f2f2;'><th>ID</th><th>Nume Angajat</th><th>Functie</th></tr>";
        
        while($row = $result->fetch_assoc()) {
            echo "<tr><td>".$row["id"]."</td><td><b>".$row["nume"]."</b></td><td>".$row["functie"]."</td></tr>";
        }
        echo "</table>";
    } else {
        echo "<p>Conexiunea a reusit, dar tabelul exista si este GOL (0 angajati).</p>";
    }
    
    $conn->close();

} catch (Exception $e) {
    // Daca apare o eroare (ex: Security Group gresit), o afisam frumos pe ecran
    echo "<div style='color: white; background-color: red; padding: 10px; margin-top: 20px;'>";
    echo "<b>Sistemul a detectat o eroare tehnica:</b><br>" . $e->getMessage();
    echo "</div>";
}
?>
