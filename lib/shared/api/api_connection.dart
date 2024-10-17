String baseUrl = 'https://testcenter.id';
String apiUrl = '$baseUrl/API';

String loginUrl = '$apiUrl/login.php';

//kelas
String kelasListUrl = '$apiUrl/fetch_kelas.php';
String kelasAddUrl = '$apiUrl/kelas_add.php';
String kelasUpdateUrl = '$apiUrl/update_kelas.php';
String kelasDeleteUrl = '$apiUrl/delete_kelas.php';

//mata pelajaran
String mapelListUrl = '$apiUrl/fetch_mapel.php';
String mapelByCategoryUrl = '$apiUrl/fetch_matpel_by_category.php';
String mapelAddUrl = '$apiUrl/mapel_add.php';
String mapelDeleteUrl = '$apiUrl/mapel_delete.php';
String mapelUpdateUrl = '$apiUrl/mapel_update.php';

//kode
String codeListUrl = '$apiUrl/fetch_kode.php';
String addCodeUrl = '$apiUrl/kode_soal_add.php';
String updateCodeUrl = '$apiUrl/kode_soal_update.php';
String fetchCodeDetailUrl = '$apiUrl/fetch_matpel_by_code.php';
String codeDeleteUrl = '$apiUrl/kode_soal_delete.php';
String deleteMapelFromCodeUrl = '$apiUrl/delete_mapel_from_code.php';
String saveSoalBulkUrl = '$apiUrl/soal_save.php';
String getSoalUrl = '$apiUrl/soal_fetch.php';
String updateSoalUrl = '$apiUrl/soal_update.php';
String deleteSoalUrl = '$apiUrl/soal_delete.php';

//kode category
String codeCategoryAddUrl = '$apiUrl/category_add.php';
String codeCategoryListUrl = '$apiUrl/category_fetch.php';
String codeCategoryDeleteUrl = '$apiUrl/category_delete.php';
String codeCategoryUpdateUrl = '$apiUrl/category_update.php';

//user management
String userManagementListUrl = '$apiUrl/user_fetch.php';
String userManagementAddUrl = '$apiUrl/user_create.php';
String userManagementUpdateUrl = '$apiUrl/user_update.php';
String userManagementDeleteUrl = '$apiUrl/user_delete.php';
String userManagementChangePasswordUrl = '$apiUrl/user_change_password.php';

//upload image
String uploadImageUrl = '$apiUrl/upload_image.php';
