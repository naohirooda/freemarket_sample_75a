$(function() {
  var input=$("#item_exhibition_price"),fee=1/10,feeIncluded=$("#sales_commission_price");
  input.on("input",function(){
    feeIncluded.text(Math.floor($(this).val() * fee));
    if($('sales_commission_price').present!=0){
      sales_commission_price.append("円");
    }
  });
  $(document).ready(function(){
    feeIncluded.text(Math.floor($("#item_exhibition_price").val() * fee));
    if($('sales_commission_price').present!=0){
      sales_commission_price.append("円");
    }
  });
});
  
$(function() {
  var input=$("#item_exhibition_price"),tax=9/10,salesProfit=$("#sales_profit_proce");
  input.on("input",function(){
    salesProfit.text(Math.ceil($(this).val() * tax));
    if($('sales_commission_price').present!=0){
      sales_profit_proce.append("円");
    }
  });
  $(document).ready(function(){
    salesProfit.text(Math.ceil($("#item_exhibition_price").val() * tax));
    if($('sales_commission_price').present!=0){
      sales_profit_proce.append("円");
    }
  });
});

