<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

$koneksi = new mysqli('localhost', 'root', '', 'db_produk');
$query = mysqli_query($koneksi, "select * from tb_produk");
$data = mysqli_fetch_all($query, MYSQLI_ASSOC);
echo json_encode($data);