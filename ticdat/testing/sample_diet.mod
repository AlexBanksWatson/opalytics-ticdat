/*********************************************
 * OPL 12.6.0.0 Model
 * Author: Joshua
 * Creation Date: Jan 19, 2017 at 6:14:30 PM
 *********************************************/
include "ticdat_sample_diet.mod";

{string} foodItems = {f | <f,c> in foods};
float foodCost[foodItems] = [f: c | <f,c> in foods];

dvar float+ purchase[foodItems];

minimize
  sum(f in foodItems) foodCost[f] * purchase[f];

subject to {

  forall (<category,min_nutrition,max_nutrition> in categories){
    sum(<f,category,qty> in nutritionQuantities) qty * purchase[f] >= min_nutrition;
    sum(<f,category,qty> in nutritionQuantities) qty * purchase[f] <= max_nutrition;
  }

}
include "ticdat_sample_diet_output.mod";
float nutrition_consumed[c in categories] = sum(nq in nutritionQuantities: nq.category == c.name) nq.qty * purchase[nq.food];

float total_cost = sum(f in foodItems) foodCost[f] * purchase[f];
execute {
   for (var f in foodItems){
      buy_food.add(f,purchase[f]);
   }

   for (var c in categories){
      consume_nutrition.add(c.name,nutrition_consumed[c]);
   }

   parameters.add("Total Cost",total_cost);
   writeOutputToFile();
}