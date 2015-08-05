<%@ include file="commons/include.jsp"%>
<script src="../lib/sweet-alert.min.js"></script>
<link rel="stylesheet" type="text/css" href="../lib/sweet-alert.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.18/jquery-ui.min.js"></script>


<c:url var="findRolesURL" value="getRoles.htm" />
<script type="text/javascript">
	$(document).ready(
			function() {
				$('#accountNo11').change(
						function() {
							$.getJSON('${findRolesURL}', {
								ajax : 'true',
								accountNumber : $(this).val(),
							}, function(data, status) {
								alert("hi");
								var html = '<option value="">Role</option>';
								var len = data.lenght;
								for (var i = 0; i < len; i++) {
									html += '<option value="' + data[i] + '">'
											+ data[i] + '</option>';
								}
								html += '</option>';

								$('#role').html(html);
							});

						});
			});
</script>

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$('#accountNov1')
								.change(
										function() {
											$
													.getJSON(
															'${findRolesURL}',
															{
																accountNumber : $(
																		this)
																		.val(),
																ajax : 'true'
															},
															function(data) {
																var html = '<option value="">Role</option>';
																var len = data.length;
																for (var i = 0; i < len; i++) {
																	html += '<option value="' + data[i].name + '">'
																			+ data[i].name
																			+ '</option>';
																}
																html += '</option>';

																$('#role')
																		.html(
																				html);
															});
										});
					});
</script>

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$('#accountNo')
								.change(
										function() {
											$
													.ajax({
														type : 'GET',
														url : "${findRolesURL}",
														data : "accountNumber="
																+ $(this).val(),
														success : function(data) {
															var obj = JSON
																	.parse(data);
															var html = '<option value="">Select Role</option>';
															var len = obj.length;
															for (var i = 0; i < len; i++) {
																html += '<option value="' + obj[i] + '">'
																		+ obj[i]
																		+ '</option>';
															}
															html += '</option>';

															$('#role').html(
																	html);
														},
														error : function(e) {
															//alert('Error in Processing');
														}
													});
										});
					});

	
	function enforceMaxLength(obj) {
		if (obj.value.length > 2048) {
			obj.value = obj.value.substring(0, 2048);
		}
	}
	
	function validateForm(){
		var role = document.getElementById('role').selectedIndex;
		if(role==0){
			swal("Please select account and role");
		}else{
			checkJSON();
		}
	}
	
	function checkJSON(){
	   try {
		    var policy = document.getElementById('policy').value; //document.getElementbyId("policy");
	        JSON.parse(policy);
		    ARPForm.submit();
	    } catch (e) {
	        swal("Policy document is invalid or the account has no permissions. Please check");
	    }
	}
	    
/* 	
	function tryParseJSON (jsonString){
	    try {
	        var o = JSON.parse(jsonString);

	        // Handle non-exception-throwing cases:
	        // Neither JSON.parse(false) or JSON.parse(1234) throw errors, hence the type-checking,
	        // but... JSON.parse(null) returns 'null', and typeof null === "object", 
	        // so we must check for that, too.
	        if (o && typeof o === "object" && o !== null) {
			    ARPForm.submit();
	        }
	    }
	    catch (e) { }
        alert("Policy document is invalid. Please correct");
	} */
</script>


<form:form id="ARPForm" action="add.htm" method="POST" modelAttribute="arp">
	<table>
		<tr>
			<td align="right">
				<span style="display: block;">
					<label for="accountNo">Account Number: *</label>
				</span>
			</td>
			<td align="center">
				<span style="display: inline-block; min-width: 300px;">
					<form:select id="accountNo" path="accountNo">
						<form:option value="NONE" label="Select Account" />
						<form:options items="${accounts}" />
					</form:select>
				</span>
			</td>
		</tr>
		<tr>
			<td align="right">
				<span style="display: block;">
					<label for="accountNo">Role Name: *</label>
				</span>
			</td>
			<td align="center">
				<span style="display: inline-block; min-width: 300px;">
					<form:select id="role" path="role">
						<form:option value="">Select Role</form:option>
					</form:select>
				</span>
			</td>
		</tr>
		<tr>
			<td align="right">
				<span style="display: block;">
					<label for="policy">Policy: *</label>
				</span>
			</td>
			<td align="center">
				<span style="display: inline-block; width: 300px;">
					<form:textarea placeholder="Maximum length of 2048. Use link https://policysim.aws.amazon.com/home/index.jsp"
								   onKeyUp="enforceMaxLength(this);" rows="40" cols="80"
								   path="policy" id="policy" />
								   
				</span><a href="https://policysim.aws.amazon.com/home/index.jsp">Policy Help</a>
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2">
				<span style="display: block;">
					<a class="buttonLink addButton" onclick="validateForm();">Add/Update</a>
				</span>
			</td>
		</tr>
	</table>
			 <script>
			 $("#policy").attr('required', ''); 
			 $("#accountNo").attr('required', ''); 
			 $("#role").attr('required', ''); 
			 </script>
</form:form>