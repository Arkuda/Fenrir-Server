
app = require('./app').init(4000)


locals = {
  title: 		   'Fenrir',
  description: 'KARO4u LOL APP',
  author: 	   'Arkuda63',
  _layoutFile: true
}


##CLIENTS

##client struct
createClient = (ipAddr,unicleName,lastPing,info,msg)->
  rClient =
    ipAddr: ipAddr
    unicleName: unicleName
    lastPing: lastPing
    info: info
    msg: msg
  return rClient
##/client struct

arrayOfClients = [createClient("ip","uname","lastping","info","msg"),'']

##is have client in base
isHaveInBase = (ipAddr,unicleName,lastPing,info,msg)->
  ishave = false
  for rClient in arrayOfClients
      if rClient.unicleName is unicleName
         res = `arrayOfClients[_i].lastPing = this.lastPing` #js
         ishave = true
  if ishave is false
    reCl = createClient(ipAddr,unicleName,lastPing,info,msg)
    arrayOfClients.push(reCl)
    ishave = true
##is have client in base

##logger
loger = (req,res,unicleName,msg)->
   ipAddr = req.connection.remoteAddress
   dateManager = new Date()
   date = dateManager.getDay() +":"+  dateManager.getMonth() +"|"+ (dateManager.getUTCHours() + 3) +":"+dateManager.getMinutes()
   isHaveInBase(ipAddr,unicleName,date,'',msg)
##logger
##CLIENTS


app.get '/', (req,res) ->
    locals.date = new Date().toLocaleDateString()
    res.render('home.ejs', locals)

#app.get '/admin', (req, res) ->
#    res.render('admin.ejs', locals)


app.get '/log/:cuniclename/:cmsg',(req, res) ->
    loger(req,res,req.params.cuniclename,req.params.cmsg)
    res.render('404.ejs', locals)

app.get '/list', (req, res) ->
    res.render('list.ejs', { locals: { arrayOfCl: arrayOfClients, title: locals.title, description: locals.description, author: locals.author, _layoutFile: locals._layoutFile }})



app.get '/*', (req,res) ->
    res.render('404.ejs', locals)









#app.get('/user/:id', function(req, res){
#res.send('user ' + req.params.id);
#});




