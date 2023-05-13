<?php
 $connection = mysqli_connect("localhost", "root", "", "db_new");

 if ($connection->connect_error) {
	 echo ("die");
 }
 
 $sql = "SELECT * FROM data";
 
 $result = mysqli_query($connection, $sql);
 
 if (!$result) {
	 echo ("die");
 }
 while ($row = mysqli_fetch_assoc($result)) {
	 $tongbs = $row['tongsobacsi'];
	 $tonglt = $row['tongsoletan'];
 }
 
 
 $dataPoints = array(
	 array("label" => "Tong Bac Si", "y" => $tongbs),
	 array("label" => "Tong Le Tan", "y" => $tonglt)
 );
	
?>
<!DOCTYPE HTML>
<html>
<head>  
<script>
window.onload = function () {
 
var chart = new CanvasJS.Chart("chartContainer", {
	animationEnabled: true,
	exportEnabled: true,
	title:{
		text: "Biểu đồ thể hiện số lượng nhân viên"
	},
	subtitles: [{
		text: "Currency Used: Thai Baht (฿)"
	}],
	data: [{
		type: "pie",
		showInLegend: "true",
		legendText: "{label}",
		indexLabelFontSize: 16,
		indexLabel: "{label} - #percent%",
		yValueFormatString: "฿#,##0",
		dataPoints: <?php echo json_encode($dataPoints, JSON_NUMERIC_CHECK); ?>
	}]
});
chart.render();
 
}
</script>
</head>
<body>
<div id="chartContainer" style="height: 370px; width: 100%;"></div>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</body>
</html>    