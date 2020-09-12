<?php 

header("Content-type: application/json; charset=utf-8");
header("Access-Control-Allow-Origin: *");

$con = new PDO("mysql:host=localhost;dbname=blog", "root", "");
$statement = $con->prepare("SELECT * FROM `postagem`");
$statement->execute();
$resultados = $statement->fetchAll(PDO::FETCH_ASSOC);

$retorno = array();
$a = 0;

foreach ($resultados as $chave => $resultado) {
    $retorno["_$a"] = $resultado;
    $a++;
}

echo json_encode($retorno);

$url = 'http://newsapi.org/v2/everything?q=bitcoin&from=2020-08-12&sortBy=publishedAt&apiKey=0c0b115fe9634fa7b1bde05ce93251c8';
$obj = json_decode(file_get_contents($url), true);

//echo $obj['status'];
