awsprofile=${awsprofile:-default}
region=${region:-}
ec2name=${ec2name:-}

while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
   fi

  shift
done

hostname=$(python3 main.py $awsprofile $region $ec2name)
if [[ "$hostname" == *"[ERROR]"* ]]; then
  echo $hostname
else 
  ssh ec2-user@$hostname
fi