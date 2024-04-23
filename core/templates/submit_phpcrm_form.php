<?php
if(ISSET($_POST))
{
	$name=$_POST['name'];
  $email=$_POST['email'];
	$phone=$_POST['phone'];
	$comment=$_POST['message'];
  $date=$_POST['date'];
  $time_interval=$_POST['time_interval'];
   $attend=$_POST['attend'];
  
  

  $field1="<b>Date of appointment:</b> ".$date;
  $field2="<b>Time Interval:</b> ".$time_interval;
  $field3="<b>Would you agree to reschedule the appointment if needed?:</b> ".$attend;
  $field4="<b>Message:</b> ".$comment;
  

}
else
{
echo "Thanks";	
exit();	
}
$Token_Key='#'; // Located in admin section under setup
$WebURL='#'; // CRM Url like https://www.abc.com/crm-folder
//Lead Fields
$post_data=array('name'=>$name,'phone'=>$phone,'email'=>$email, 'field_1'=>$field1."<br>".$field2."<br>".$field3."<br>".$field4);
$PHPCRM = curl_init();
curl_setopt_array($PHPCRM, array(
  CURLOPT_URL=>$WebURL.'/index.php/crm_api/leads/add_lead/'.$Token_Key,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => $post_data,
));

$response = curl_exec($PHPCRM);
curl_close($PHPCRM);
header("Location:thanks.php");
exit();
//echo $response;
?>