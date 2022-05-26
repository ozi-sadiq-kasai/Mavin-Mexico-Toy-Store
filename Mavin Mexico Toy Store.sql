--Find product category which drives the biggest Profits

with temptable  as 
(select Product_Category,(Product_Price - Product_Cost) Product_profit
from products)
	select Product_Category,sum(Product_profit)Sum_Profit
	from temptable
	group by Product_Category
	order by Sum_Profit desc


--Find the biggest product category sales across store locations
select Product_Category,Units,Store_Name
from products p
join sales s
on p.Product_ID = s.Product_ID
join stores st
on st.Store_ID = s.Store_ID
group by Product_Category,Units,Store_Name
order by Units desc

--Finding sales being lost with out-of-stock products at certain locations

with temp as
(select Product_Category,Product_Price,Stock_On_Hand,Store_Name
from stores s
join inventory i
on s.Store_ID = i.Store_ID
join products p
on i.Product_ID = p.Product_ID
where Stock_On_Hand = 0)
	select distinct(Store_Name),sum(Product_Price)
	over( partition by Store_Name) Total_Loss
	from temp
	order by Total_Loss desc
	

--How much money is tied up in the inventory at the Toy stores?
with W as
(select Product_Category,(Product_Price*Stock_On_Hand) Amount
from inventory
join products
on inventory.Product_ID = products.Product_ID
where Stock_On_Hand > 0)
	select sum(AMOUNT) Total_Amount_In_Stock
	from W

--Find Stock_On_Hand in Residential Stores and the Product Category
select distinct(Store_Name),Product_Category,Stock_On_Hand 
from stores
join inventory
on  stores.Store_ID = inventory.Store_ID
join products
on products.Product_ID = inventory.Product_ID
where Store_Location = 'Residential'


