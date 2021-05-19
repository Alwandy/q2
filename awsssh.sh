awsprofile=${awsprofile:-default}
region=${region:-}
ec2name=${ec2name:-}

while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
        # echo $1 $2 // Optional to see the parameter:value result
   fi

  shift
done

hostname=$(python3 main.py $awsprofile $region $ec2name)
SUB='Linux'
if [[ "$hostname" == *"[ERROR]"* ]]; then
  echo $hostname
else 
  ssh ec2-user@$hostname
fi