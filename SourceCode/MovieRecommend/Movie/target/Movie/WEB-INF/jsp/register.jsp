<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<head>

    <meta charset="utf-8">
    <title>register</title>
    <link rel="SHORTCUT ICON" href="../assets/img/knowU.ico"/>
    <!-- CSS -->
    <link href="../assets/css/bootstrap.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/regandlogcommon.css">
    <link rel="stylesheet" href="../assets/css/register.css">
    <script src="../assets/js/jquery.js"></script>
    <script src="../assets/js/jquery.min.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <![endif]-->

</head>

<body>
<div class="page-container">
    <h1 style="color: white">Please fill in the registration information</h1>
    <form id="regForm_mod">
        <%--User name --%>
        <div id="d1">

            <span  style="color: white" class="glyphicon glyphicon-user"></span>
            <input type="text" name="username"  id="regName" placeholder="User Name" required="required" />
            <span style="color: red"  class="usernameerror"></span>

        </div>


        <%--邮箱--%>
        <div  id="d2">
            <span style="color: white" class="glyphicon glyphicon-envelope"></span>
            <input type="email" name="email"  id="email" placeholder="Email" required="required">
            <span  style="color: red" class="emailerror"></span>
        </div>

        <%-- password--%>
        <div id="d3">
            <span style="color: white" class="glyphicon glyphicon-asterisk"></span>
            <input type="password" name="password" id="pwd" placeholder="Password" required="required">
            <span   style="color: red" class="pwderror"></span>

        </div>

            <%--确认 password--%>
        <div id="d4">
            <span style="color: white" class="glyphicon glyphicon-asterisk"></span>
            <input type="password" id="pwdRepeat" placeholder="Confirm password" required="required">
            <span   style="color: red" class="pwdRerror"></span>

        </div>

        <button  class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal #identifier" type="button" style="background-color: #00b4ef" onclick="REGISTER.reg()">Sign up</button>
            <%--邮箱提示信息--%>

         <ul class="bRadius2 mail">
                <li data-mail="@126.com" class="item item3" type="none">@nus.edu.com</li>
                <li data-mail="@163.com" class="item item4" type="none">@Yahoo.com</li>
                <li data-mail="@gmail.com" class="item item5" type="none">@gmail.com</li>
         </ul>
    </form>





    <%--//错误提示信息--%>
    <div id="mz_Float">
        <div id="tip"style="color: red" class="bRadius2"></div>
    </div>





    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 810px">
            <div class="modal-content"  style="height:620px;width: 810px">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="width: 30px">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Please choose a movie you like</h4>
                </div>
                <div class="modal-body">
                    <table id="tab" border="2px">
                        <tr>
                            <td>
                                <h6>${sessionScope.TopRegDefaultMovie[0].moviename}</h6>
                                <img  alt="0" name="movieid"  class="img" movieId="${sessionScope.TopRegDefaultMovie[0].movieid}" src="${sessionScope.TopRegDefaultMovie[0].picture}">

                            </td>
                            <td>
                                <h6>${sessionScope.TopRegDefaultMovie[1].moviename}</h6>
                                <img alt="1"  name="movieid" class="img" movieId="${sessionScope.TopRegDefaultMovie[1].movieid}" src="${sessionScope.TopRegDefaultMovie[1].picture}">
                            </td>
                            <td>
                                <h6>${sessionScope.TopRegDefaultMovie[2].moviename}</h6>
                                <img alt="2" name="movieid"  class="img" movieid="${sessionScope.TopRegDefaultMovie[2].movieid}" src="${sessionScope.TopRegDefaultMovie[2].picture}">
                            <td>
                                <h6>${sessionScope.TopRegDefaultMovie[3].moviename}</h6>
                                <img  alt="3" name="movieid" class="img" movieId="${sessionScope.TopRegDefaultMovie[3].movieid}" src="${sessionScope.TopRegDefaultMovie[3].picture}">

                            </td>
                            <td>
                                <h6>${sessionScope.TopRegDefaultMovie[4].moviename}</h6>
                                <img  alt="4" name="movieid" class="img" movieId="${sessionScope.TopRegDefaultMovie[4].movieid}" src="${sessionScope.TopRegDefaultMovie[4].picture}">

                            </td>

                        </tr>
                        <tr>
                            <td>
                                <h6>${sessionScope.TopRegDefaultMovie[5].moviename}</h6>
                                <img  alt="5" name="movieid" class="img" movieId="${sessionScope.TopRegDefaultMovie[5].movieid}" src="${sessionScope.TopRegDefaultMovie[5].picture}">

                            </td>
                            <td>
                                <h6>${sessionScope.TopRegDefaultMovie[6].moviename}</h6>
                                <img alt="6" name="movieid" class="img" movieId="${sessionScope.TopRegDefaultMovie[6].movieid}" src="${sessionScope.TopRegDefaultMovie[6].picture}">
                            </td>
                            <td>
                                <h6>${sessionScope.TopRegDefaultMovie[7].moviename}</h6>
                                <img  alt="7" name="movieid" class="img" movieId="${sessionScope.TopRegDefaultMovie[7].movieid}" src="${sessionScope.TopRegDefaultMovie[7].picture}">
                            <td>
                                <h6>${sessionScope.TopRegDefaultMovie[8].moviename}</h6>
                                <img  alt="8" class="img"  name="movieid" movieId="${sessionScope.TopRegDefaultMovie[8].movieid}" src="${sessionScope.TopRegDefaultMovie[8].picture}">

                            </td>
                            <td>
                                <h6>${sessionScope.TopRegDefaultMovie[9].moviename}</h6>
                                <img  alt="9" class="img"  name="movieid" movieId="${sessionScope.TopRegDefaultMovie[9].movieid}" src="${sessionScope.TopRegDefaultMovie[9].picture}">

                            </td>
                        </tr>
                    </table>


                </div>
                <div class="modal-footer" style="position: relative;top:40px;text-align: center;">

                    <button type="button" class="btn btn-default" data-dismiss="modal" style="width: 55px;height: 30px;">Close</button>
                    <button type="button" class="btn btn-primary" style="width: 55px;height: 30px" onclick="movieSubmit()">Submit</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

</div>


<%--选择喜欢的电影--%>
<script type="text/javascript">

        $(".img").click(function () {

            $(this).toggleClass("imgSelected");
           // alert($(this).css('border-color'));
    })

   function movieSubmit() {
       var imgs=$(".imgSelected");
       console.log(imgs);
       var ids = "";
       for(var i =0;i< imgs.size();i++){
           var temp=","+$(imgs[i]).attr("movieId")+".";
           ids+=temp;
       }
       if(ids!="") {
           $.post("../customer/register/movieSubmit", {'ids': ids}, function (data) {
               if(data=="ok") {
                   alert("Submitted successfully");
                   $('#myModal').modal('hide');
                   location.href = "../page/login";
               }
               else
                   alert("Please select at least one movie");
           })
       }
       else
           alert("Please select at least one movie");

    }

</script>

<!-- 注册事件-->

<script type="text/javascript">

    //User name 获得焦点
    $("#regName").focus(function () {
        $("#regName").removeClass("errorC");
        $("#regName").removeClass("checkedN");
        $(".usernameerror").show();
        $(".usernameerror").text("  ");


    });
    //邮箱获得焦点
    $("#email").focus(function () {
        $("#email").removeClass("errorC");
        $("#email").removeClass("checkedN");
        $(".emailerror").show();
        $(".emailerror").text("  ");
    });
    // password获得焦点
    $("#pwd").focus(function () {
        $("#pwd").removeClass("errorC");
        $("#pwd").removeClass("checkedN");
        $(".pwderror").show();
        $(".pwderror").text("  ");
    });
    //确认 password获得焦点
    $("#pwdRepeat").focus(function () {
        $("#pwdRepeat").removeClass("errorC");
        $("#pwdRepeat").removeClass("checkedN");
        $(".pwdRerror").show();
        $(".pwdRerror").text("  ");
    });

    //User name 失去焦点
    $("#regName").blur(function () {
        if ($("#regName").val() == "") {
            $("#regName").addClass("errorC");
            $(".usernameerror").html("<span>▲User name can not be empty</span>");
            $(".usernameerror").show();


        }
        else if($("#regName").val().length>10 || $("#regName").val().length<4){
            $(".usernameerror").show();
            $(".usernameerror").html("<span>▲User name should be between 4 to 10</span>").show();
            $("#regName").addClass("errorC");
        }
        else{
            $("#regName").addClass("checkedN");
            $(".usernameerror").show();
            $(".usernameerror").text("");
        }
        //判断User name 是否被占用
        var surl = "";

        var username = encodeURI(encodeURI($("#regName").val()));
        console.log(username);
        $.ajax({url:surl + "/customer/check/"+username+"/1?r=" + Math.random(),
            success : function(data) {
                if (data.data) {
                } else {
                    $(".usernameerror").show();
                    $(".usernameerror").html("<span>▲The user has been registered, please re-enter</span>");
                    $("#regName").addClass("errorC");
//                    style = 'position: relative ;top:-20px;left: 200px;'
                }
            }
        });
    });


    // password失去焦点
    $("#pwd").blur(function () {
        var reg1=/^.*[\d]+.*$/;
        var reg2=/^.*[A-Za-z]+.*$/;
        var reg3=/^.*[_@#%&^+-/*\/\\]+.*$/;//验证 password

        if ($("#pwd").val() == "") {
            $("#pwd").addClass("errorC");
            $(".pwderror").show();
            $(".pwderror").html("▲ password can not be empty");
        }
        else if ($("#pwd").val().length>16 || $("#pwd").val().length<8){
            $("#pwd").addClass("errorC");
            $(".pwderror").show();
            $(".pwderror").html("<span style = 'position: relative ;left: 28px;'>◀ password 8-16 characters in length</span>");
        }
        else if (!(reg1.test($("#pwd").val()) ||  reg2.test($("#pwd").val())|| reg3.test($("#pwd").val()) )){
            $("#pwd").addClass("errorC");
        }
        else{
            //输入正确
            $("#pwd").addClass("checkedN");
            $(".pwderror").show();
            $(".pwderror").text("");
        }

    })
    //确认 password失去焦点
    $("#pwdRepeat").blur(function () {
        if ($("#pwd").val() != $("#pwdRepeat").val() || $("#pwdRepeat").val() =="") {
            $("#pwdRepeat").addClass("errorC");
            $(".pwdRerror").show();
            $(".pwdRerror").html("▲ Inconsistent passwords");
        }
        else{
            $("#pwdRepeat").addClass("checkedN");
            $(".pwdRerror").show();
            $(".pwdRerror").text("");
        }

    })

    //邮箱栏键盘操作
    $("#email").keyup(function () {//键盘监听keyup,keydown,keypress
//        alert("键盘操作");
        var emailVal = $("#email").val();
        var emailValN = emailVal.replace(/\s/g,'');//去空
        emailValN = emailValN.replace(/[\u4e00-\u9fa5]/g,'');//屏蔽中文
        if(emailValN!=emailVal){
            $("#email").val(emailValN);//
        }

        var mailVal = emailValN.split("@");
        var mailHtml = mailVal[0];
        if(mailHtml.length>15)
        {
            mailHtml=mailHtml.slice(0,15)+"...";//字数超加省略
        }
        for(var i=1;i<6;i++)
        {
            var M = $(".item"+i).attr("data-mail");
            $(".item"+i).html(mailHtml+M);
        }
    });

    //邮箱提示
    $(".item").click(function () {
        var a = $("#email").val();
        var b = $(this).attr("data-mail");
        $("#email").val(a+b);
        $("#email").trigger("focus");


    });

    $("#email").click(function () {


        $(".mail").show();
        return false;
    });

    $(document).click(function(){
        $(".mail").hide();

    });
    //邮箱失去焦点
    $("#email").blur(function () {
//        $(".mail").hide();
        reg=/^\w+[@]\w+((.com)|(.net)|(.cn)|(.org)|(.gmail))$$/;
        if ($("#email").val() == "") {
            $("#email").addClass("errorC");
            $(".emailerror").show();
            $(".emailerror").html("▲Email can not be empty");

        }
        else if(!reg.test($("#email").val())){
            $("#email").addClass("errorC");
            $(".emailerror").show();
            $(".emailerror").html("▲Email format error");
        }

        else {
            $(".emailerror").show();
            $(".emailerror").text("");
            $("#email").addClass("checkedN");
        }

        //判断邮箱是否被占用
        var surl = "";
        $.ajax({url:surl + "/customer/check/"+escape($("#email").val())+"/3?r=" + Math.random(),
            success : function(data) {
                if (data.data) {
                } else {
                    $(".emailerror").show();
                    $(".emailerror").html("<span>▲Email has been registered, please re-enter</span>");
                    $("#email").addClass("errorC");
//                    style = 'position: relative ;left: 290px;'
                }
            }
        });
    });

    var REGISTER={
        param:{
            surl:""
        },
        inputcheck:function(){
            var flag = true;
            var reg=/^\w+[@]\w+((.com)|(.net)|(.cn)|(.org)|(.gmail))$$/;

            // can not be empty检查
            if ($("#regName").val() == "") {
                alert("User name  can not be empty！");
                flag = false;
                $('#identifier').modal('hide');
            }
            if($("#regName").val().length>10 || $("#regName").val().length<4){
                alert("Please input 4-10 length User name ！");
                flag = false;
                $('#identifier').modal('hide');
            }

            if ($("#email").val() == "") {
                alert("Email can not be empty！");
                flag = false;
                $('#identifier').modal('hide');
            }
            if(!reg.test($("#email").val())){
                alert("Email format error！");
                flag = false;
                $('#identifier').modal('hide');
            }


            if ($("#pwd").val() == "") {
                alert(" password can not be empty！");
                flag = false;
                $('#identifier').modal('hide');
            }
            if($("#pwd").val().length>16 || $("#pwd").val().length<8){
                alert(" password length should be between 8 to 16");
                flag = false;
                $('#identifier').modal('hide');
            }
            // password检查
            if ($("#pwd").val() != $("#pwdRepeat").val()) {
                alert("Passwords are inconsistent！");
                flag = false;
                $('#identifier').modal('hide');
            }
            return flag;
        },
        beforeSubmit:function() {
            var username = encodeURI(encodeURI($("#regName").val()));
            //检查用户和邮箱是否已经被占用
            $.ajax({
                url : REGISTER.param.surl + "../customer/checkboth/"+username+"/"+escape($("#email").val())+"/4?=" + Math.random(),
                success : function(data) {
                    if (data.data) {
                        REGISTER.doSubmit();
                    } else {
                        alert("User name or the mailbox has been registered");
                        $('#identifier').modal('hide');

                    }
                }
            });

        },
        doSubmit:function() {
            $.post("../customer/register",$("#regForm_mod").serialize(), function(data){
                if(data.status == 200){
                    alert('User registration is successful, please select your favorite movie！');
//                    REGISTER.login();
                    $('#myModal').modal('show');

                } else {
                    alert("Registration failed！");
                    $('#identifier').modal('hide');
                }
            });
        },
        login:function() {
            location.href = "../page/login";
            return false;
        },
        reg:function() {
//            this.doSubmit();
            if (this.inputcheck()) {
                this.beforeSubmit();
            }
        }
    };
</script>

<!-- Javascript背景轮播 -->
<script type="text/javascript">
    var curIndex = 0;
    //时间间隔(单位毫秒)，每秒钟显示一张，数组共有3张图片放在img文件夹下
    var timeInterval = 2000;
    //定义一个存放照片位置的数组，可以放任意个，在这里放3个
    var arr = new Array();
    arr[0] = "../assets/img/loginimg/1.jpg";
    arr[1] = "../assets/img/loginimg/2.jpg";
    arr[2] = "../assets/img/loginimg/3.jpg";
    setInterval(changeImg, timeInterval);
    function changeImg() {
        if (curIndex == arr.length - 1) {
            curIndex = 0;
        } else {
            curIndex += 1;
        }
        //设置body的背景图片
        document.body.style.backgroundImage = "URL("+arr[curIndex]+")";  //显示对应的图片
    }
</script>
</body>

</html>

