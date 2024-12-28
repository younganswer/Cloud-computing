#!/bin/bash

printf "Post Supplier Data\n\n"

TOTAL=100
API_URL="CoffeeSupplierLoadBalancer-1986211423.us-east-1.elb.amazonaws.com:8080/supplier-add"

printf "Progress: %03d/%03d" 0 $TOTAL

for i in $(seq 0 $(($TOTAL - 1))); do
	NAME=$(printf "Supplier%03d" $i)
	ADDRESS=$(printf "Address%03d" $i)
	CITY=$(printf "City%03d" $i)
	STATE=$(printf "State%03d" $i)
	EMAIL=$(printf "Email%03d@example.com" $i)
	PHONE=$(printf "010-%04d-%04d" $i $i)
	curl -X POST -H "Content-Type: application/json" -d "{
		\"name\":\"$NAME\",
		\"address\":\"$ADDRESS\",
		\"city\":\"$CITY\",
		\"state\":\"$STATE\",
		\"email\":\"$EMAIL\",
		\"phone\":\"$PHONE\"
	}" $API_URL > /dev/null 2>&1
	printf "\b\b\b\b\b\b\b"
	printf "%03d/%03d" $(($i + 1)) $TOTAL
done

printf "\n\nDone\n"