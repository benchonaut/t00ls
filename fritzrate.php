<?php
// Pollt daten per UPNP aus der Fritzbox
$client = new SoapClient(
  null,
  array(
    'location'   => "http://192.168.178.1:49000/igdupnp/control/WANCommonIFC1",
    'uri'        => "urn:schemas-upnp-org:service:WANCommonInterfaceConfig:1",
    'soapaction' => "urn:schemas-upnp-org:service:WANCommonInterfaceConfig:1#",
    'noroot'     => True
  )
);

$status = $client->GetCommonLinkProperties();
$status2 = $client->GetAddonInfos();

print_r($status);
print_r($status2);

$UpstreamBit = $status['NewLayer1UpstreamMaxBitRate'];
$UpstreamMBit = $UpstreamBit/1000/1000;
$UpstreamMByte = $UpstreamMBit/8;

$DownstreamBit = $status['NewLayer1DownstreamMaxBitRate'];
$DownstreamMBit = $DownstreamBit/1000/1000;
$DownstreamMByte = $DownstreamMBit/8;


// Bytes in Bits umrechnen (Ermittelte Werte * 8)
$NewTotalMBytesSent = $status2['NewTotalBytesSent']*8/1024/1024;
$NewTotalMBytesReceived	= $status2['NewTotalBytesReceived']*8/1024/1024;

$ByteSendRate      = $status2['NewByteSendRate'];
$ByteReceiveRate   = $status2['NewByteReceiveRate'];
$MByteSendRate      = $status2['NewByteSendRate']/1000/100;
$MByteReceiveRate   = $status2['NewByteReceiveRate']/1000/100;


echo "trafficout:",$MByteSendRate,"\ntrafficin:",$MByteReceiveRate,"\ntotalout:",$NewTotalMBytesSent,"\ntotalin:",$NewTotalMBytesReceived,"\nloadUp:",$MByteSendRate/$UpstreamMBit*100,"\nloadDown:",$MByteReceiveRate/$DownstreamMBit*100,"\nstreamUp:",$UpstreamMBit,"\nstreamDown:",$DownstreamMBit;
?>

