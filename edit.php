<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

$koneksi = new mysqli('localhost', 'root', '', 'db_produk');

$id_produk = $_POST ['id_produk'];
$nama_produk = $_POST ['nama_produk'];
$harga_produk = $_POST ['harga_produk'];

$data = mysqli_query($koneksi, "update tb_produk set nama_produk = '$nama_produk', harga_produk='$harga_produk' where id_produk='$id_produk'");

if ($data) {
    echo json_encode([
        'pesan' => 'Sukses Update'
    ]);
} else{
    echo json_encode([
        'pesan' => 'Gagal Update'
    ]);
}