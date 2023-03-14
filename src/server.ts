import express from "express";
import {execSync} from "child_process";

const app = express();

app.get('/', (req: any, res: any) => { 
    let t = execSync("yosys");
    res.send(t.toString());
});

const port = process.env.PORT || 3232

app.listen(port, () => { console.log('Server is up on port ' + port + '!') })