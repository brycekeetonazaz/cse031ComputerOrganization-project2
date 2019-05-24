#include <stdio.h>
#include <stdlib.h>

int calcBars(int price, int money, int numWrappers, int bars){
	
	if(money/price > 0)
	{
		printf("You first buy %d bars\n", money/price);
		bars = money/price;
	}
	else if(bars > 0 && bars/numWrappers > 0)
	{
		printf("You then will get another %d bars\n", bars/numWrappers);
		bars = (bars/numWrappers);
	}
	else{
		return 0;
	}
	
	int numBars = bars;
	numBars += calcBars(price, 0, numWrappers, bars);
	return numBars;
	
}

int main(int argc,char* argv[]){
	
	int priceOfBar = 0;
	int moneyPaid = 0;
	int numWrappersForRedemption = 0;
	int barsOwned = 0;
	
	printf("Welcome to BobCat Candy, home to the famous BobCat Bars!\nPlease enter the price of a BobCat Bar:\n");
	scanf("%d", &priceOfBar);
	printf("Please enter the number of wrappers needed to exchange for a new bar:\n");
	scanf("%d", &numWrappersForRedemption); 
	printf("How, how much do you have?\n");
	scanf("%d", &moneyPaid); 
	printf("Good! Let me run the number ...\n");
	
	barsOwned = calcBars(priceOfBar, moneyPaid, numWrappersForRedemption, 0);
	
	printf("With $ %d , you will receive a maximum of %d BobCat Bars!", moneyPaid, barsOwned);
	
	return 0;

}