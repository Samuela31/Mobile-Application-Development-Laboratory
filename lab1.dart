import 'dart:io';
void main()
{
var choice = 4;
var bill=0.0;
var name;
var l=[0,0,0];
print("Enter username:");
name = stdin.readLineSync();
do
{
print("Select item: ");
print("1.Pen- Rs.50");
print("2.Marker- Rs.22");
print("3.A4 Sheet- Rs.30");
print("Select choice (press 0 to get bill): ");
choice = int.parse(stdin.readLineSync()!);
switch(choice){
case 0:
break;
case 1: { bill+=50; l[0]+=50;}
break;
case 2: { bill+=22; l[1]+=22;}
break;
case 3: { bill+=30; l[2]+=30;}
break;
default: { print("Invalid choice"); }
break;

}
}while(choice!=0);
print("Username: $name");
print("Total bill is Rs.$bill");
print("Items you have bought:");
stdout.write("Pen- Rs.");
print(l[0]);
stdout.write("Marker- Rs.");
print(l[1]);
stdout.write("A4 Sheet- Rs.");
print(l[2]);
if(bill>50)
{
print("Applying 10% discount");
bill=bill-0.1*bill;
print("Total bill is Rs.$bill");
}
else if(bill>100)
{
print("Applying 20% discount");
bill=bill-0.2*bill;
print("Total bill is Rs.$bill");
}
if(bill>150)
{
print("Your shipping charge is free");
}
else if(bill!=0)
{
bill+=30;
print("Shipping charges: Rs.30");
print("Total bill is Rs.$bill");
}
}

