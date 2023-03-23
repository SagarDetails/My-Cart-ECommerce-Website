function add_to_cart(pId,pName,pPrice){
									let cart=localStorage.getItem("cart");
									if(cart==null){
										let products=[];
										let product={productId: pId, productName: pName, productQuantity: 1, productPrice: pPrice}
										products.push(product);
										localStorage.setItem("cart", JSON.stringify(products));
										console.log("Product is added for the first time!");
									}else{
										
										let pCart=JSON.parse(cart);
										let oldProduct=pCart.find((item)=> item.productId==pId);
										if(oldProduct){
											
											oldProduct.productQuantity=oldProduct.productQuantity+1;
											pCart.map((item)=>{
												if(item.productId==oldProduct.productId){
													item.productQuantity=oldProduct.productQuantity;
												}
											})
											localStorage.setItem("cart", JSON.stringify(pCart));
											console.log("Product quantity is increased!");
											
										}else{
											let product={productId: pId, productName: pName, productQuantity: 1, productPrice: pPrice}
											pCart.push(product);
											localStorage.setItem("cart", JSON.stringify(pCart));
											console.log("Product is added!");
											
										}
										
									}
									updateCart();
								}
								
								
								
								function updateCart(){
									console.log("This is updateCart function...");
									let cartString=localStorage.getItem("cart");
									let cart=JSON.parse(cartString);
									if(cart==null || cart.length==0){
										console.log("Cart is empty!!");
										$(".cart-item").html("(0)");
										$(".cart-body").html("<h3>Cart does not have any item</h3>");
										$(".checkout-btn").attr('disabled',true);
										
									}
									else{
										console.log("This is else part");
										console.log(cart);
										$(".cart-item").html('('+cart.length+')');
										
										let table=`
											<table class="table">
												<thead class="thread-light">
													<tr>
														<th>Item Name</th>
														<th>Price</th>
														<th>Quantity</th>
														<th>Total Price</th>
														<th>Action</th>
													</tr>
												</thead>
										`;
										
										cart.map((item)=>{
											
											table+=
													`<tr>
														<td>${item.productName}</td>
														<td>${item.productPrice}</td>
														<td>${item.productQuantity}</td>
														<td>${item.productPrice*item.productQuantity}</td>
														<td><button onclick="removeItemFromCart(${item.productId})" class='btn btn-danger btn-sm'>Remove</button></td>
													</tr>`
													
													
										})
										
										table=table+`</table>`
										$(".cart-body").html(table);
										$(".checkout-btn").attr('disabled',false);
									}
									
								}
								
								
								function removeItemFromCart(pId){
									let cart=JSON.parse(localStorage.getItem("cart"));
									let newCart=cart.filter((item)=>item.productId!=pId);
									localStorage.setItem("cart", JSON.stringify(newCart));
									updateCart();
								}
								
								function goToCheckOut(){
									window.location="checkout.jsp";
								}
								
								
								$(document).ready(function(){
									updateCart();
								})