
app = require('./app').init(4000)


locals = {
  title: 		   'Node | Express | EJS | Boostrap',
  description: 'A Node.js applicaton bootstrap using Express 3.x, EJS, Twitter Bootstrap, and CSS3',
  author: 	   'C. Aaron Cois, Alexandre Collin',
  _layoutFile: true
}


##CLIENTS
arrayOfClients = ['','']


##client struct
createClient = (ipAddr,unicleName,lastPing,info,msg)=>
  rClient =
    ipAddr: ipAddr
    unicleName: unicleName
    lastPing: lastPing
    info: info
    msg: msg
  return rClient
##/client struct

##is have client in base
isHaveInBase = (ipAddr,unicleName,lastPing,info,msg)->
  ishave = false
  for rClient in arrayOfClients
      if rClient.unicleName is unicleName
         res = `arrayOfClients[_i].lastPing = this.lastPing`
         ishave = true
  if ishave is false
    createClient(ipAddr,unicleName,lastPing,info,msg)
    ishave = true
##is have client in base


##CLIENTS


app.get '/', (req,res) ->
    locals.date = new Date().toLocaleDateString()
    res.render('home.ejs', locals)

#app.get '/admin', (req, res) ->
#    res.render('admin.ejs', locals)


app.get '/log/:msg',(req, res) ->
    loger(req,res,req.params.msg)
    #res.render('admin.ejs', locals)


app.get '/*', (req,res) ->
    res.render('404.ejs', locals)




loger = (req,res,msg)->
    ipAddr = req.connection.remoteAddress






#app.get('/user/:id', function(req, res){
#res.send('user ' + req.params.id);
#});




