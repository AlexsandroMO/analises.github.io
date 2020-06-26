<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">

    <title>Análises de Textos</title>
    <!-- <link rel="stylesheet" href="style.css">-->
    <style>
        body{
            background: rgba(63, 120, 185, 0.836);
            font: normal 15px;
            color: rgb(107, 105, 105);
        }
        header{
            color: white;
            text-align: center;
        }
        #alinha-texto-logo{
            background: white;
            margin: auto;
            color: rgb(107, 105, 105);
        }

        #alinha-nav{
            text-align: center;
            color: white;
        }

        section{
            background: white;
            border-radius: 10px;
            padding: 15px;
            width: 600px;
            margin: 20px;
            box-shadow: 3px 5px 10px black;
            position: relative;
            /* left: 50%; */
        }
        h1{
            text-shadow: 0.1em 0.1em 0.07em #333;
        }

        #alinha-options{   
            position: relative;
            left: 45%;
        }

        #sep-text{
            border-radius: 10px;
            padding: 2px;
            width: 400px;
            border-top: 1.2px #ccc;
            box-shadow: 1px 2px 5px rgb(102, 100, 100);
            position: absolute;
            left: 150px;
        }

        #var-text-pre{
            border-radius: 10px;
            padding: 2px;
            width: 150px;
            border-top: 1.2px #ccc;
            box-shadow: 1px 2px 5px rgb(102, 100, 100);
            position: absolute;
            left: 150px;
        }

        #var-text-suf{
            border-radius: 10px;
            padding: 2px;
            width: 150px;
            border-top: 1.2px #ccc;
            box-shadow: 1px 2px 5px rgb(102, 100, 100);
            position: absolute;
            left: 400px;
        }

        #alinha-texto-suf{
            position: absolute;
            left: 340px;
        }

        #option_test{
            margin-left: 20px;
            padding-left: 10px;  
        }

        #bt1{
            font-style: Arial, sans-serif;
            font-weight: normal;
            width: 130px;
            height: 40px;
            text-align: center;
            margin-right: 5px;
        }
        #p-alinha-button{
            padding-top: 20px;
        }

        footer{
            color: white;
            text-align: center;
            font-style: italic;
        }

    </style>

</head>
<!--###########################################################-->
<body>
    <contaner>


        <nav class="navbar navbar-expand-md navbar-dark bg-dark" id="alinha-nav">
            Analises de Textos
        </nav>
    
        <section> 
            <div id="alinha-options">
                <p>Options:
                    <input type="radio" name="option_test" id="option_test" checked>
                    <label for="Separa">Separa</label>
                    <input type="radio" name="option_test" id="option_test">
                    <label for="Ajusta">Concatenar</label>
                </p>
            </div>

            <div id="sep1">
                
                <p><strong>Busca de Textos:</strong>
                    <input type="text" name="sep-text" id="sep-text">
                </p>
                <p><strong>Prefixo:</strong>
                    <input type="text" name="var-text" id="var-text-pre">
                    <strong id=alinha-texto-suf>Sufixo:</strong>
                    <input type="text" name="var-text" id="var-text-suf">
                </p>
                <div> 
                    <p id="p-alinha-button">  
                        <button type="button" class="btn btn-secondary" id="bt1" onclick="analisa()">Analisar</button>
                        <button type="button" class="btn btn-warning" id="bt1" onclick="limpar()">Limpar</button>
                    </p>
                </div>
            </div>
            
            <div>
                <hr>
                <p><strong>Lista:</strong></p>
                <p id="result"></p>
            </div>
        </section> 

    </contaner>
</body>
<!--###########################################################-->
<script>
    //window.alert('ok!')
    function analisa(){
        var in_text = document.getElementById('sep-text')
        var text_pre = document.getElementById('var-text-pre')
        var text_suf = document.getElementById('var-text-suf')
        var res = document.getElementById('result')
        var new_text = ''
        var list_breaked = []
        var match_test = in_text.value.split(/\s+/)
        var option_test = document.getElementsByName('option_test')
        
        res.innerHTML = ''

        if (option_test[0].checked){
           // Libera a análise de separação

            if (in_text.value.length == 0 && text_pre.value.length == 0){
                window.alert('[ERRO] - É preciso preencher os campos par análise')
            }else{
            
                for (let a=0; a<match_test.length; a++){
                    new_text = match_test[a]
                    list_breaked[a] = new_text 
                }

                for (let a=0; a<list_breaked.length; a++){

                    //res.innerHTML += list_breaked[a] + '<br>'
            
                    if (text_pre.value == list_breaked[a][0]){
                        res.innerHTML += list_breaked[a] + '<br>'
                    }
                    else if (text_pre.value == list_breaked[a].substring(0,3)){
                        res.innerHTML += list_breaked[a] + '<br>'
                    }
                    else if (text_pre.value == list_breaked[a]){
                        res.innerHTML += list_breaked[a] + '<br>'
                    } 
                }
            }

            function analisar(){
                //window.alert('ok!')
                var in_text = document.getElementById('sep-text2')
                var text_pre = document.getElementById('var-text-pre')
                var text_suf = document.getElementById('var-text-suf')
                var res = document.getElementById('result2')
                var new_text = ''
                var list_breaked = []
                var match_test = in_text.value.split(/\s+/);
                res.innerHTML = ''
                
                for (let a=0; a<match_test.length; a++){
                    new_text = match_test[a]
                    list_breaked[a] = new_text 
                }


                for (let a=0; a<list_breaked.length; a++){
                    res.innerHTML += text_pre.value + list_breaked[a] + text_suf.value + "<br>"
                }
            }
        }
        else if (option_test[1].checked){
           // Libera a análise de separação
           //window.alert("ok")

            if (in_text.value.length == 0 || text_pre.value.length == 0){
                window.alert('[ERRO] - É preciso preencher os campos par análise')
            }else{

                for (let a=0; a<match_test.length; a++){
                    new_text = match_test[a]
                    list_breaked[a] = new_text 
                }

                for (let a=0; a<list_breaked.length; a++){
                    res.innerHTML += text_pre.value + list_breaked[a] + text_suf.value + "<br>"
                }
            }

        }
    }
    
    function limpar(){
        //window.alert("ok")

        var in_text = document.getElementById('sep-text')
        var text_pre = document.getElementById('var-text-pre')
        var text_suf = document.getElementById('var-text-suf')
        var res = document.getElementById('result')
        res.innerHTML = ''
        text_pre.value = ''
        text_suf.value = ''
        in_text.value = ''
    }

</script>
<!--###########################################################-->
<!--<script src="script_sep.js"></script>-->
</html>
