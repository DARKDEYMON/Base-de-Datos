<?php
// Create connection to Oracle
	$conn = oci_connect("ventas", "nadaesrealasies","//localhost/xe");
	if (!$conn) {
	   $m = oci_error();
	   echo $m['message'], "\n";
	   exit;
	}
	else {
	   print "Connected to Oracle!";
	}
	$stid = oci_parse($conn, 'SELECT * FROM clientes');
	oci_execute($stid);
	echo "<table border='1'>\n";
	$llabe=true;
	while ($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)) {
		if($llabe)
		{
			echo "<tr>\n";
			foreach (array_keys($row) as$it)
			{
				echo "<td>".ucwords(strtolower(str_replace("_"," ",$it)))."</td>\n";
			}
			echo "</tr>\n";
			$llabe=false;
		}
	    echo "<tr>\n";
	    foreach ($row as $item) {
		    echo "    <td>" . ($item !== null ? htmlentities($item, ENT_QUOTES) : "") . "</td>\n";
	    }
	    echo "</tr>\n";
	}
	echo "</table>\n";
	
	// Close the Oracle connection
	oci_close($conn);
?>