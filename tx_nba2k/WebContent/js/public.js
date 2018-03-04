function changeImg(){
        var img = document.getElementById("img"); 
        img.src = "${ctx}/authImage?date=" + new Date();;
    }


		function zhuxiao($scope,$http){

			$scope.exit = function(){
				$http.get("User/exit.do").then(function(value) {
					var text = window.location.href;
					location.href=text;
				});
			};
			
		}
		
		var zhuce=function($scope,$http){
				$scope.reg = function(){
					$http({
						url:"User/reg.do",
						method: "post",
						params:{
							"uname":$("#runame").val(),
							"pwd":$("#rpwd").val(),
							"pname":$("#rpname").val()
						}
					}).then(function(resp) {
						var text = window.location.href;
						location.href=text;
					}, function(reason) {
						alert("网络繁忙");
					});
				};
			};
		
 		function denglu($scope,$http){
 			$scope.login = function(){
 				$http({
					method:"post",
					params:{uname:$("#uname").val(),pwd:$("#pwd").val()},
					url:"User/login.do"
				}).then(function successCallback(obj){
					console.log(obj);
					if(obj.data!=null){
						var text = window.location.href;
						location.href=text;
					}else{
						$scope.errorMess= "用户名密码错误";
					}
				});
			};
 			
 		}
 		function regUser($scope,$http){
 			$("#register").attr("disabled",true);
 			var qpwdReg = false;
 			var rpwdReg = false;
 			var unameReg = false;
 			var pnameReg = false;
 			$scope.regPname = function(){
	 			if($("#rpname").val()!=null && $("#rpname").val()!=''){
	 				$("#rpnameSpan").text("请输入昵称");
		 			$http({
		 				url: "User/RegPname.do",
		 				params: {"pname":$("#rpname").val()}
		 			}).then(function(resp) {
		 				if(resp.data.meg){
		 					$("#rpnameSpan").css("color","green").text("昵称可使用");
		 					pnameReg = true;
		 				}else{
		 					$("#rpnameSpan").css("color","red").text("昵称重复");
		 					pnameReg = false;
		 				}
		 				passReg();
		 			});
	 			}else{
	 				$("#rpnameSpan").css("color","red").text("昵称不能为空");
	 				pnameReg = false;
	 				passReg();
	 			}
	 			
 			};
 			$("#rpname").focus(function(){
 				$("#rpnameSpan").css("color","black").text("请输入昵称");
 			}) ;
 			
 			$scope.regUser = function(){
	 			if($("#runame").val()!=null && $("#runame").val()!=''){
	 				$("#runameSpan").text("请输入用户名");
		 			$http({
		 				url: "User/RegUser.do",
		 				params: {"uname":$("#runame").val()}
		 			}).then(function(resp) {
		 				if(resp.data.meg){
		 					$("#runameSpan").css("color","green").text("用户名可使用");
		 					unameReg = true;
		 				}else{
		 					$("#runameSpan").css("color","red").text("用户名已被注册");
		 					unameReg = false;
		 				}
		 				passReg();
		 			});
	 			}else{
	 				$("#runameSpan").css("color","red").text("用户名不能为空");
	 				unameReg = false;
	 				passReg();
	 			}
	 			
 			};
 			$("#runame").focus(function(){
 				$("#runameSpan").css("color","black").text("请输入用户名");
 			}) ;	
 			
 			$scope.regPwd = function(){
 				if($("#rpwd").val().length>=6){
 					$("#rpwdSpan").css("color","green").text("密码可以使用");
 					rpwdReg = true;
 				}else{
 					$("#rpwdSpan").css("color","red").text("密码长度至少6位");
 					rpwdReg = false;
 				}
 				$scope.regQpwd();
 				passReg();
 			};
 			$("#rpwd").focus(function(){
 				$("#rpwdSpan").css("color","black").text("请填写6位密码");
 			}) ;
 			$scope.regQpwd = function(){
 				
 				if($("#qpwd").val()==$("#rpwd").val()&&$("#rpwd").val().length>=6){
 					$("#qpwdSpan").css("color","green").text("密码一致");
 					qpwdReg = true;
 				}else{
 					$("#qpwdSpan").css("color","red").text("密码不一致");
 					qpwdReg = false;
 				}
 				passReg();
 			};
 			
 			$("#qpwd").focus(function(){
 				$("#qpwdSpan").css("color","black").text("请再次输入密码");
 			}) ;		 
 			function passReg(){
 				if(qpwdReg&&rpwdReg&&unameReg&&pnameReg){
 					$("#register").attr("disabled",false);
 				}else{
 					$("#register").attr("disabled",true);
 				}
 				
 			}
 			
 			
 			
 			
 		}
 		
 		
 	
 		
 	