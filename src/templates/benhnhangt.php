<?php
$connection = mysqli_connect("localhost", "root", "", "db_new");

if ($connection->connect_error) {
    echo ("die");
}

$sql = "SELECT * FROM thongkebenhnhan";

$result = mysqli_query($connection, $sql);

if (!$result) {
    echo ("die");
}
while ($row = mysqli_fetch_assoc($result)) {
    $nam = $row['nam'];
    $nu = $row['nu'];
    $p1 = $row['p1'];
    $p2 = $row['p2'];
    $p3 = $row['p3'];

}


$dataPoints = array(
    array("label" => "Nam", "y" => $nam),
    array("label" => "Nu", "y" => $nu)
);

$dataPoints1 = array(
    array("label" => "p1", "y" => $p1),
    array("label" => "p2", "y" => $p2),
    array("label" => "p3", "y" => $p3),
)

?>
<!DOCTYPE HTML>
<html>

<head>
    <script>
        window.onload = function () {

            var chart = new CanvasJS.Chart("chartContainer", {
                animationEnabled: true,
                exportEnabled: true,
                title: {
                    text: "Biểu đồ thể hiện số lượng bệnh nhân theo giới tính"
                },
                subtitles: [{
                    text: "(Số liệu được tự cập nhật)"
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

<!-- <script>
        window.onload = function () {

            var chart = new CanvasJS.Chart("chartContainer", {
                animationEnabled: true,
                exportEnabled: true,
                title: {
                    text: "Biểu đồ thể hiện phòng bệnh bệnh nhân đã chọn"
                },
                subtitles: [{
                    text: "(Số liệu được tự cập nhật)"
                }],
                data: [{
                    type: "pie",
                    showInLegend: "true",
                    legendText: "{label}",
                    indexLabelFontSize: 16,
                    indexLabel: "{label} - #percent%",
                    yValueFormatString: "฿#,##0",
                    dataPoints: <?php echo json_encode($dataPoints1, JSON_NUMERIC_CHECK); ?>
	}]
});
        chart.render();
 
}
    </script> -->
</head>

<body>
    <div id="chartContainer" style="height: 370px; width: 100%;"></div>
    <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</body>

</html>