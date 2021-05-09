<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="./assets/css/style-login.css" rel="stylesheet" type="text/css"/>
    <link href="./assets/css/bootstrap.css" rel="stylesheet">
    <!--external css-->

    <!-- Custom styles for this template -->
    <link href="./assets/css/style.css" rel="stylesheet">
    <script src="./assets/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="./assets/js/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
    <script src="./assets/js/star-rating.min.js" type="text/javascript"></script>
    <script src="./assets/js/jquery.js" type="text/javascript"></script>

</head>
<body>

<div class="container" style="margin-top: 10%">
    <div class="row">
        <div class="col-md-offset-3 col-md-6">
            <form class="form-horizontal" id="logForm_mod">
                <span class="heading">Admin login</span>
                <div class="form-group">
                    <input type="text" class="form-control" id="loginAdminname" placeholder="Account" name="adminname">
                    <i class="fa fa-user"></i>
                </div>
                <div class="form-group help">
                    <input type="password" class="form-control" id="loginAdminpassword" placeholder="Password" name="adminpassword">
                    <i class="fa fa-lock"></i>
                    <a href="#" class="fa fa-question-circle"></a>
                </div>
                <div class="form-group">
                    <button  id="login" type="button" class="btn btn-default" onclick="ADMINLOGIN.login()">Login</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
    var ADMINLOGIN = {
        checkInput:function() {

            if(!$("#loginAdminname").val()) {
                alert("Please input account！");
                return false;
            }
            if(!$("#loginAdminpassword").val()) {
                alert("Please input password！");
                return false;
            }
            return true;
        },
        doLogin:function() {
            $.post("./login", $("#logForm_mod").serialize(),function(data){
                if (data.status == 200) {
                    alert("Success！");
                    location.href="./movie";
                } else {
                    alert("Failed：" + data.msg);
                }
            });
        },
        login:function() {
            if (this.checkInput()) {
                this.doLogin();
            }
        }

    };
</script>
</body>
</html>