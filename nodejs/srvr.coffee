#   BY ARKUDA63
#
#
#            {
#         }   }   {
#        {   {  }  }
#         }   }{  {
#        {  }{  }  }                    _____       __  __
#       ( }{ }{  { )                   / ____|     / _|/ _|
#     .- { { }  { }} -.               | |     ___ | |_| |_ ___  ___
#    (  ( } { } { } }  )              | |    / _ \|  _|  _/ _ \/ _ \
#    |`-..________ ..-'|              | |___| (_) | | | ||  __/  __/
#    |                 |               \_____\___/|_| |_| \___|\___|
#    |                 ;--.
#    |                (__  \            _____           _       _
#    |                 | )  )          / ____|         (_)     | |
#    |                 |/  /          | (___   ___ _ __ _ _ __ | |_
#    |                 (  /            \___ \ / __| '__| | '_ \| __|
#    |                 |/              ____) | (__| |  | | |_) | |_
#    |                 |              |_____/ \___|_|  |_| .__/ \__|
#     `-.._________..-'                                  | |
#                                                        |_|
#




app = require('./app').init(4000)
fs = require('fs')



locals = {
  title: 		   'Fenrir',
  description: 'KARO4u LOL APP',
  author: 	   'Arkuda63',
  siteUrl:     "localhost:4000",
  fileSave:    "save.frs",
  fileReqLog:  "reqlog.frs",
  fileShort:   "short.frs",
  uploadPath:  "/temp/",
  shortLink:   "",
  isFirst:     false,
  _layoutFile: true,
  debugIsOn:   true
}



##-------------CLIENTS---------

##client struct
createClient = (ipAddr,unicleName,lastPing,msg)->
  rClient =
    ipAddr: ipAddr
    unicleName: unicleName
    lastPing: lastPing
    msg: msg
  return rClient
##/client struct

arrayOfClients = [createClient("ip","uname","lastping","msg"),'']

##is have client in base
isHaveInBase = (ipAddr,unicleName,lastPing,msg)->
  ishave = false
  for rClient in arrayOfClients
      if rClient.unicleName is unicleName
         dateManager = new Date()
         res = `arrayOfClients[_i].lastPing = dateManager.toJSON();` #js
         ishave = true
  if ishave is false
    reCl = createClient(ipAddr,unicleName,lastPing,msg)
    arrayOfClients.push(reCl)
    ishave = true
##is have client in base

##logger
loger = (req,res,unicleName,msg)->
   ipAddr = req.connection.remoteAddress
   dateManager = new Date()
   date = dateManager.toJSON()
   isHaveInBase(ipAddr,unicleName,date,msg)
##logger

##-------------CLIENTS---------



##-----------LOAD AND SAVE-----
saveToJson = (varSave,fileSave)->
  sjson = JSON.stringify(varSave)
  fs.writeFileSync(fileSave,sjson)

loadJson = (fileToLoad)->
  fs.readFile(fileToLoad,(err,data)->
      arrayOfClients = JSON.parse(data))
##-----------LOAD AND SAVE-----



##-----------DEBUG AREA--------
printDebug = (msg)->
  if locals.debugIsOn
    console.info("[D]: " + msg)

logRequest = (req)->
    fileinn = fs.readFile(locals.fileReqLog,(err,data)->
      dateManager = new Date()
      date = dateManager.toJSON()
      data = data + "\n" + "[REQ] in " + date + " ; on \"" + req.url + "\" ; with ip: " + req.connection.remoteAddress + " ; "
      fs.writeFile(locals.fileReqLog,data)
      )
##-----------DEBUG AREA--------


##------------SHORTER----------

ShortLinks = {}

getRandom = (max,min)->
    return Math.floor(Math.random() * (max - min + 1)) + min


shorterCreate = (req) ->
    #ShortLinks = loadJson(locals.fileShort)
    randomized = [getRandom(9,0),getRandom(9,0),getRandom(9,0),getRandom(9,0),getRandom(9,0),getRandom(9,0),getRandom(9,0)]
    randomized = randomized[0] + "" + randomized[1] + "" + randomized[2] + "" + randomized[3] + "" + randomized[4] + "" + randomized[5] + "" + randomized[6]
    ShortLinks[randomized] = req.body.FullUrl;
    saveToJson(ShortLinks,locals.fileShort)
    ShortLinks = null
    return  randomized


shorterGet = (req,res,id) ->
    ShortLinks = loadJson(locals.fileShort)
    printDebug(ShortLinks)
    shortI = ShortLinks[id]
    printDebug(shortI)
    return shortI


##------------SHORTER----------




##------------ROUTING----------

app.get '/', (req,res) ->
    locals.date = new Date().toLocaleDateString()
    logRequest(req)
    res.render('home.ejs', locals)


app.get '/log/:cuniclename/:cmsg',(req, res) ->
    loger(req,res,req.params.cuniclename,req.params.cmsg)
    saveToJson(arrayOfClients,locals.fileSave)
    logRequest(req)
    res.render('404.ejs', locals)


app.get '/list', (req, res) ->
    loadJson(locals.fileSave)
    logRequest(req)
    res.render('list.ejs', { locals: { arrayOfCl: arrayOfClients, title: locals.title, description: locals.description, author: locals.author, _layoutFile: locals._layoutFile }})


app.get '/upld', (req,res) ->
    logRequest(req)
    res.render('upload.ejs', locals)



app.post '/upld', (req,res,next) ->
    sfile = req.files.userFile
    fs.writeFile(locals.uploadPath + sfile.name,sfile)

app.get '/s', (req,res) ->
    locals.isFirst = true;
    res.render('short.ejs', locals)

app.post '/s', (req,res) ->
    locals.shortLink = shorterCreate(req,res)
    locals.isFirst = false;
    res.render('short.ejs', locals)

app.get '/s/:sid', (req,res) ->
    redirectUrl = shorterGet(req,res,req.params.sid)
    if (not (redirectUrl.substring(0,7) is "http://"))  and  (not (redirectUrl.substring(0,8)is "https://"))
      redirectUrl = "http://" + redirectUrl
    res.redirect(redirectUrl)


app.get '/*', (req,res) ->
    logRequest(req)
    res.render('404.ejs', locals)

##------------ROUTING----------


