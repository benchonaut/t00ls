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

print_r($status);
 print_r($status2);

// Bytes in Bits umrechnen (Ermittelte Werte * 8)
$NewTotalBytesSent = $status2['NewTotalBytesSent'];
$NewTotalBytesReceived	= $status2['NewTotalBytesReceived'];

$ByteSendRate      = $status2['NewByteSendRate'];
$ByteReceiveRate   = $status2['NewByteReceiveRate'];
$ByteSendRateBIT      = $status2['NewByteSendRate']*8;
$ByteReceiveRateBIT   = $status2['NewByteReceiveRate']*8;

$UpstreamBIT = $status['NewLayer1UpstreamMaxBitRate']*10/1024;
$Upstream = $UpstreamBIT/8;
$DownstreamBIT = $status['NewLayer1DownstreamMaxBitRate']*10/1024;
$Downstream = $DownstreamBIT/8;

//echo "trafficout:",$ByteSendRate," trafficin:",$ByteReceiveRate," totalout:",$NewTotalBytesSent/1024/1024," totalin:",$NewTotalBytesReceived/1024/1024,"";
echo "trafficout:",$ByteSendRate," trafficin:",$ByteReceiveRate," totalout:",$NewTotalBytesSent," totalin:",$NewTotalBytesReceived," loadUp:",$DownstreamBIT/$ByteReceiveRateBIT," loadDown:",$UpstreamBIT/$ByteSendRateBIT;
?>

