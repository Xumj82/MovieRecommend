<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh" data-theme="light">

<head>
    <meta charset="utf-8"/>
    <link rel="SHORTCUT ICON" href="./assets/img/knowU.ico"/>
    <link data-react-helmet="true" rel="prefetch" href="./assets/img/user_cover_image.jpg"/>
    <script src="./assets/js/jquery.js"></script>
    <script src="./assets/js/bootstrap.min.js"></script>
    <script src="./assets/js/star-rating.min.js" type="text/javascript"></script>
    <link href="./assets/css/star-rating.css" media="all" rel="stylesheet" type="text/css"/>
    <link href="./assets/css/douban.main.css" rel="stylesheet"/>
    <link href="./assets/css/bootstrap.css" rel="stylesheet">
    <link href="./assets/css/SuggestList.css" rel="stylesheet" type="text/css">
    <style>
        .component-poster-detail .nav-tabs > li {
            width: 50% !important;
        }
    </style>
    <%--star rating 类--%>
    <script type="text/javascript">
        window.onload = function () {
            $("input[name='allstar']").rating({
                        showClear: false,
                        size: 'xs',
                        showCaption: false,
                        readonly: true,
                    }
            );
        }
    </script>
</head>

<body class="Entry-body">
<div id="root">

    <div data-reactid="5">
        <!-- 导航栏-->
        <nav class="navbar navbar-default" role="navigation" style="background-color: black;margin-bottom: 0%">
            <a class="navbar-brand" href="./" style="color: white">Movie recommendation</a>

            <div class="col-xs-4">
                <input id="inp-query" class="form-control"
                       style="margin-bottom: 8px;margin-top: 8px;border-radius: 5px;" name="search_text" maxlength="60"
                       placeholder="Search.." value="">
            </div>
            <a class="navbar-brand" href="./index" style="color: white">Select</a>
            <!-- 判断用户是否登录-->
            <c:if test="${sessionScope.user == null}">
                <a class="dream" href="javascript:window.location.href='./page/register'" id="register"
                   style="float: right;color: white;font-size: 13pt;margin-top: 10px;margin-right: 10px"><span
                        style="color: white" class="glyphicon glyphicon-user"></span> Sign up</a>
                <a class="dream" href="javascript:window.location.href='./page/login'"
                   style="float: right;color: white;font-size: 13pt;margin-top: 10px;margin-right: 10px"><span
                        style="color: white" class="glyphicon glyphicon-log-in"></span> Sign in</a>
            </c:if>
            <c:if test="${sessionScope.user != null}">

                <a class="dream" id="logout" href='javascript:$.get("./page/logout",function (data) {
            location.href = "./"
        });'
                   style="float: right;color: white;font-size: 13pt;margin-top: 10px;margin-right: 10px"><span
                        style="color: white" class="glyphicon glyphicon-log-in"></span> Logout</a>
                <a class="dream" href="javascript:"
                   style="float: right;color: white;font-size: 13pt;margin-top: 10px;margin-right: 10px"><span
                        style="color: white" class="glyphicon glyphicon-user"></span> ${sessionScope.user.username}</a>
            </c:if>
        </nav>
    </div>

    <main role="main" class="App-main" data-reactid="48">
        <div data-reactid="49">

            <div id="ProfileHeader" class="ProfileHeader" data-reactid="61">
                <div class="Card" data-reactid="62">
                    <div class="ProfileHeader-userCover" data-reactid="63">
                        <div class="UserCoverEditor" data-reactid="64">
                            <!-- 背景图片 -->
                            <div data-reactid="65">
                                <div class="UserCover" data-reactid="71">
                                    <!-- 背景图片 -->
                                    <div class="VagueImage UserCover-image" data-src="/assets/img/user_cover_image.jpg"
                                         data-reactid="72">
                                        <img src="./assets/img/user_cover_image.jpg">
                                        <div class="VagueImage-mask" data-reactid="73"></div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="ProfileHeader-wrapper" data-reactid="75">

                        <!-- 背景图片一下的用户信息部分-->
                        <div class="ProfileHeader-main" data-reactid="76" style="margin-bottom: 0px;">

                            <!-- 用户头像 -->
                            <div class="UserAvatarEditor ProfileHeader-avatar" style="top:-57px;margin-left: 20px;"
                                 data-reactid="77">
                                <div class="UserAvatar" data-reactid="78">
                                    <img class="Avatar Avatar--large UserAvatar-inner" width="160" height="160"
                                         src="./assets/img/user_avatar.jpg" srcset="./assets/img/user_avatar.jpg 2x"
                                         data-reactid="79"/>
                                </div>
                            </div>

                            <div class="ProfileHeader-content" data-reactid="87">

                                <!-- User name 称 -->
                                <div class="ProfileHeader-contentHead" data-reactid="88">
                                    <h1 class="ProfileHeader-title" data-reactid="89">
                                        <span class="ProfileHeader-name"
                                              data-reactid="90">${sessionScope.user.username}</span>
                                    </h1>
                                </div>

                                <!-- 头像下的留白空间 -->
                                <div style="overflow:hidden;transition:height 300ms ease-out;"
                                     class="ProfileHeader-contentBody" data-reactid="93">
                                    <div data-reactid="94">
                                        <div class="ProfileHeader-info" data-reactid="95">
                                            <div class="ProfileHeader-infoItem" data-reactid="96">
                                                <div class="ProfileHeader-iconWrapper" data-reactid="97">
                                                </div>
                                                <div class="ProfileHeader-divider" data-reactid="102"></div>
                                                <div class="ProfileHeader-divider" data-reactid="104"></div>
                                                <div class="ProfileHeader-iconWrapper" data-reactid="105">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!--编辑个人资料按钮 -->
                                <div class="ProfileHeader-contentFooter" data-reactid="109">

                                    <div class="ProfileButtonGroup ProfileHeader-buttons" data-reactid="115"
                                         style="bottom: 30px;">
                                        <a href="#" class="Button Button--blue" data-toggle="modal"
                                           data-target="#userEditDialog"
                                           onclick="editUser(${sessionScope.user.userid})">
                                            <!-- react-text: 117 -->Edit
                                            <!-- /react-text -->
                                            <!-- react-text: 118 -->personal
                                            <!-- /react-text -->
                                            <!-- react-text: 119 -->profile
                                            <!-- /react-text -->
                                        </a></div>
                                </div>

                            </div>
                        </div>

                    </div>

                </div>
            </div>

            <div class="Profile-main" data-reactid="120">
                <div class="Profile-mainColumn" data-reactid="121">
                    <div class="Card ProfileMain" id="ProfileMain" data-reactid="122">

                        <div class="ProfileMain-header" data-reactid="123">

                            <!-- 滑动标签<li> -->
                            <ul class="nav nav-tabs" role="tablist">
                                <li role="presentation" class="active" style="text-align: center"><a href="#film-info"
                                                                                                     aria-controls="film info"
                                                                                                     data-toggle="tab"
                                                                                                     aria-expanded="true">like</a>
                                </li>
                                <li role="presentation" class="" style="text-align: center"><a id="reviewsId"
                                                                                               href="#reviews"
                                                                                               aria-controls="reviews"
                                                                                               data-toggle="tab"
                                                                                               aria-expanded="false">Evaluated</a>
                                </li>
                            </ul>

                            <!-- 喜欢的电影<li> -->
                            <div class="tab-content">
                                <div class="tab-pane fade active in" id="film-info" data-zop-feedlistfather="1"
                                     data-reactid="158">
                                    <div class="List-header" data-reactid="159">
                                        <h4 class="List-headerText" data-reactid="160"><span data-reactid="161">
              <!-- react-text: 162 -->Movies i like
                          </span></h4>
                                        <div class="List-headerOptions" data-reactid="164"></div>
                                    </div>
                                    <div class="" data-reactid="165">

                                        <c:if test="${sessionScope.movies != null}">
                                            <c:forEach var="item" items="${sessionScope.movies}">

                                                <div class="List-item" data-reactid="166">
                                                    <p class="ul first"></p>
                                                    <table width="100%" class="">
                                                        <tr class="item">
                                                            <td width="100" valign="top">
                                                                <a class="nbg" value="${item.movieid}" onclick='javascript:$.post("./Customer/Description",{id:$(this).attr("value")}, function (data) {
                                                  if (data=="success") {
                                                      location.href = "./MovieDescription"
                                                  } else {
                                                  }
                                              })' title="${item.moviename}">
                                                                    <img src="${item.picture}" width="75"
                                                                         alt="${item.moviename}" class=""/>
                                                                </a>
                                                            </td>
                                                            <td valign="top">
                                                                <div class="pl2">

                                                                    <a value="${item.movieid}" onclick='javascript:$.post("./Customer/Description",{id:$(this).attr("value")}, function (data) {
                                                  if (data=="success") {
                                                      location.href = "./MovieDescription"
                                                  } else {
                                                  }
                                              })' class="">
                                                                            ${item.moviename}
                                                                    </a>
                                                                    <p class="pl"><fmt:formatDate type="date"
                                                                                                  value="${item.showyear}"
                                                                                                  pattern="yyyy-MM-dd"/>Released</p>
                                                                    <p class="pl">Director：${item.director}</p>
                                                                    <div class="star clearfix">
                                                                        <span class="allstar40"></span>
                                                                        <span class="rating_nums">${item.averating}</span>
                                                                        <span class="pl">(${item.numrating} reviews)</span>

                                                                    </div>


                                                                </div>

                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <div id="collect_form_11584016"></div>

                                                </div>
                                            </c:forEach>
                                        </c:if>
                                    </div>

                                </div>

                                <!-- 评价过的电影<li> -->
                                <div class="tab-pane fade" id="reviews" data-zop-feedlistfather="1" data-reactid="158">
                                    <div class="List-header" data-reactid="159">
                                        <h4 class="List-headerText" data-reactid="160"><span data-reactid="161">
              <!-- react-text: 162 -->Movies I reviewed
                          </span></h4>
                                        <div class="List-headerOptions" data-reactid="164"></div>
                                    </div>

                                    <div class="" data-reactid="165">
                                        <!-- 评价过的电影 -->
                                        <c:if test="${sessionScope.reviews != null}">
                                            <c:forEach var="item" items="${sessionScope.reviews}">

                                                <div class="List-item" data-reactid="166">
                                                    <p class="ul first"></p>
                                                    <table width="100%" class="">
                                                        <tr class="item">
                                                            <td width="100" valign="top">
                                                                <a class="nbg" value="${item.movieid}" onclick='javascript:$.post("./Customer/Description",{id:$(this).attr("value")}, function (data) {
                                                  if (data=="success") {
                                                      location.href = "./MovieDescription"
                                                  } else {
                                                  }
                                              })'>
                                                                    <img src="${item.picture}" width="75" class=""/>
                                                                </a>
                                                            </td>
                                                            <td valign="top">
                                                                <div class="pl2">
                                                                    <div><input name="allstar" value="${item.star}">
                                                                    </div>
                                                                    <div><b style="font-size: 11pt">Your Rating:</b> <span
                                                                            style="font-size: 9pt">${item.star}</span>
                                                                    </div>
                                          <span property="v:dtreviewed" content="2018-03-19" class="main-meta">
                                              <fmt:formatDate type="date" value="${item.reviewtime}"
                                                              pattern="yyyy-MM-dd"/>
                                          </span>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </c:forEach>
                                        </c:if>

                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <!-- 右侧模块 -->
                <div class="Profile-sideColumn" data-za-module="RightSideBar" data-reactid="294">
                    <div class="Card" data-reactid="295">
                        <div class="Card-header Profile-sideColumnTitle" data-reactid="296">
                            <div class="Card-headerText" data-reactid="297">Recommended movies</div>
                        </div>
                    </div>
                    <!-- 右侧电影推荐列表 -->
                    <div class="Profile-lightList" data-reactid="329">

                        <!-- 右侧电影推荐列表 -->
                        <c:if test="${sessionScope.TopDefaultMovie != null}">
                            <c:forEach var="item" items="${sessionScope.TopDefaultMovie}">
                                <a class="Profile-lightItem" onclick='javascript:$.post("./Customer/Description",{id:$(this).attr("value")}, function (data) {
            if (data=="success") {
                location.href = "./MovieDescription"
            } else {
            }
        })' value="${item.movieid}"><span class="Profile-lightItemName" data-reactid="331">${item.moviename}</span><span
                                        class="Profile-lightItemValue" data-reactid="332">${item.averating}</span></a>
                            </c:forEach>
                        </c:if>

                    </div>

                </div>

            </div>
        </div>
    </main>

</div>

<!-- 用户编辑资料框 -->
<div class="modal fade" id="userEditDialog" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">Modify user information</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="edit_user_form">
                    <div class="form-group">
                        <label for="edit_password" class="col-sm-2 control-label">user password</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="edit_password" placeholder="" name="password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit_email" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="edit_email" placeholder="" name="email">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="UPDATE.updateUser()">Save</button>
            </div>
        </div>
    </div>
</div>

<%--智能提示框--%>
<div class="suggest" id="search-suggest" style="display: none; top:43px;left: 155px;">
    <ul id="search-result">
    </ul>
</div>

</body>

<%--搜索栏--%>
<script>

    $("#inp-query").bind("keyup", function () {
        var width = document.getElementById("inp-query").offsetWidth + "px";
        $("#search-suggest").show().css({
            width: width
        });

        //在搜索框输入数据，提示相关搜索信息
        var searchText = $("#inp-query").val();

        $("#search-result").children().remove();
        $.post("./search", {"search_text": searchText}, function (data) {
            if (data.status == 200) {
                if (data.data.length != 0) {
                    $.each(data.data, function (i, item) {
                        var headHtml = $("#movie-tmpl").html();
                        var formatDate = item.showyear;
                        headHtml = headHtml.replace(/{id}/g, item.movieid);
                        headHtml = headHtml.replace(/{cover}/g, item.picture);
                        headHtml = headHtml.replace(/{moviename}/g, item.moviename);
                        headHtml = headHtml.replace(/{showyear}/g, dateFormat(formatDate, 'yyyy-MM-dd'));
                        headHtml = headHtml.replace(/{director}/g, item.director);
                        headHtml = headHtml.replace(/{averating}/s, item.averating);
                        $("#search-result").append(headHtml);
                    })
                }
                else {
//                $("#search-result").html("not found");
                    alert("opps!!cannot found this movie")
                }
            }
            else {
//            alert("failed to load image ");
            }

        })
    });


</script>

<%--智能提示框模板--%>
<script type="text/tmpl" id="movie-tmpl">
 <li id="searchResult">
   <div>
      <a value="{id}" style="text-decoration:none" onclick='javascript:$.post("./Customer/Description",{id:$(this).attr("value")}, function (data) {
            if (data=="success") {
                location.href = "./MovieDescription"
            } else {
            }
        })'>
         <div style="float:left">
            <img src="{cover}" style="width:80px;height:120px">
         </div>
         <div  style="padding:12px">
            <span>&nbsp;&nbsp;&nbsp;&nbsp;Title：{moviename}</span>
            <br>
            <span>&nbsp;&nbsp;&nbsp;&nbsp;Release:{showyear}</span>
            <br>
            <span>&nbsp;&nbsp;&nbsp;&nbsp;Director：{director}</span>
             <br>
            <span>&nbsp;&nbsp;&nbsp;&nbsp;Rating：{averating}</span>
         </div>
       </a>
   </div>
 </li>


</script>

<!-- string cst时间转date-->
<script>
    function dateFormat(date, format) {
        date = new Date(date);
        var o = {
            'M+': date.getMonth() + 1, //month
            'd+': date.getDate(), //day
        };
        if (/(y+)/.test(format))
            format = format.replace(RegExp.$1, (date.getFullYear() + '').substr(4 - RegExp.$1.length));

        for (var k in o)
            if (new RegExp('(' + k + ')').test(format))
                format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ('00' + o[k]).substr(('' + o[k]).length));
        return format;
    }
</script>

<script type="text/javascript">

    function editUser(id) {
        $.ajax({
            type: "get",
            url: "./user/edit.action",
            data: {"id": id},
            success: function (data) {   // Movie的JSON字符串传过来就行
//                  $("#edit_userid").val(data.userid);
//                  $("#edit_username").val(data.username);
//                  $("#edit_password").val(data.password);
//                  $("#edit_registertime").val(data.registertime);
//                  $("#edit_lastlogintime").val(data.lastlogintime);
                $("#edit_email").val(data.email);
            }
        });
    }

    <%--更改 password--%>
    var UPDATE = {
        checkInput: function () {

            if ($("#edit_password").val()) {
                if ($("#edit_password").val().length < 6 || $("#edit_password").val().length > 12) {
                    alert(" password must be between 6-12！");
                    return false;
                }

            }

            return true;
        },
        updateUs: function () {
            $.post("./user/update.action", {
                "userid": "${sessionScope.user.userid}",
                "password": $("#edit_password").val(),
                "email": $("#edit_email").val()
            }, function (data) {
                alert("user password updated！");
                window.location.reload();
            });
        },
        updateUser: function () {
            if (this.checkInput()) {
                this.updateUs();
            }
        }
    };
</script>


</html>