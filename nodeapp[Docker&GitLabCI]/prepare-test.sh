pwd
echo "will start running while loop...."
i=1
while [ $i -le 10 ]
do
    echo $i
    i=`expr $i + 1`
done
