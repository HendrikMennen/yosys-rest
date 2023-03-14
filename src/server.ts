import express from "express";
import {execSync} from "child_process";

const app = express();

app.get('/', (req: any, res: any) => { 
    res.send(execSync("yosys").toString());
});

app.get('/ls', (req: any, res: any) => { 
    res.send(execSync("ls").toString());
});

const port = process.env.PORT || 3232

app.listen(port, () => { console.log('Server is up!')});