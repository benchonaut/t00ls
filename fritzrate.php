<?php
// Pollt daten per UPNP aus der Fritzbox
$client = new SoapClient(
  null,
  array(
    'location'   => "http://192.168.178.1:49000/igdupnp/control/WANCommonIFC1",
    'uri'        => "urn:schemas-upnp-org:service:WANCommonInterfaceConfig:1",
    'soapaction' => "",
    'noroot'     => True
  )
);

$status = $client->GetCommonLinkProperties();
$status2 = $client->GetAddonInfos();
// print_r($status);
// print_r($status2);
// Bytes in Bits umrechnen (Ermittelte Werte * 8)
$ByteSendRate      = $status2['NewByteSendRate'];
$ByteSendRateBIT      = $status2['NewByteSendRate']*8;
$ByteReceiveRate   = $status2['NewByteReceiveRate'];
$ByteReceiveRateBIT   = $status2['NewByteReceiveRate']*8;
$NewTotalBytesSent = $status2['NewTotalBytesSent'];
$NewTotalBytesReceived	= $status2['NewTotalBytesReceived'];

//print_r($status2);
echo "trafficout:",$ByteSendRate," trafficin:",$ByteReceiveRate," totalout:",$NewTotalBytesSent/1024/1024," totalin:",$NewTotalBytesReceived/1024/1024,"";
?>

