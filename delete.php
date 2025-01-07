<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

$koneksi = new mysqli('localhost', 'root', '', 'db_produk');
$id_produk = $_POST ['id_produk'];

$data = mysqli_query($koneksi, "delete from tb_produk where id_produk='$id_produk'");

if ($data) {
    echo json_encode([
        'pesan' => 'Sukses Delete'
    ]);
} else{
    echo json_encode([
        'pesan' => 'Gagal Delete'
    ]);
}