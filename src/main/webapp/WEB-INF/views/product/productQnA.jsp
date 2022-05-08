<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script type = "text/javascript" src="/resources/_ui/desktop/common/js/review.js"></script>
</head>
<body>

<script>
    console.log("================");
    console.log("JS TEST");
    
    var pIdValue = 1;
    
    reviewService.getReviewList({pIdValue:1, pageNum:1, amount:10}, function(list){
        
        for(var i = 0, len = list.length||0; i < len; i++){
            console.log(list[i]);
        }
    });
</script>    
</body>
</html>