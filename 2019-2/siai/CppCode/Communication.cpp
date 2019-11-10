#include "Communication.h"

Communication::Communication(double kp, double ki, double kd, double posDesejada){
    this->param1 = kp;
    this->param2 = ki;
    this->param3 = kd;
    this->param4 = posDesejada;
    this->matlabPath = "usr/local/MATLAB/R2018b/bin/";
    this->workspaceAtual = "/home/zamith/Documents/Faculdade/10o_Semestre/SIAI/";
}

void Communication::writeMatlabScript(){
    ofstream outfile;
    outfile.open("script.m");
    outfile << "clear" << endl;
    outfile << "clc" << endl;
    outfile << "close all" << endl;
    outfile << "posDesejada = "<< this->param4 << ";" << endl;
    outfile << "kp = "<< this->param1 << ";" << endl;
    outfile << "ki = "<< this->param2 << ";" << endl;
    outfile << "kd = "<< this->param3 << ";" << endl;
    outfile << "pid = sim('PID.slx')" << endl;
    outfile << "posfinal.getdatasamples(size(pid,1))" << endl;
    outfile << "tempo = pid(size(pid,1))" << endl;
    outfile.close();
}


void Communication::runMatlabScript(){
    string str = "export PATH=/"+this->matlabPath+":$PATH";
    const char *command = str.c_str(); 
    system(command);

    // str = "echo $PATH";
    // command = str.c_str();
    // system(command);

    str = "matlab -nodisplay -nosplash -nodesktop -r \"run('"+this->workspaceAtual+"parametros.m');exit;\" >> \"output.txt\"";
    command = str.c_str(); 
    system(command);
}

double Communication::readMatlabOutput(){
    ifstream infile; 
    string line;
    double valor;
    bool encontrou = false;

    infile.open("output.txt");
    while (getline(infile,line)){ 
        if(line.rfind("tempo",0)==0){
            encontrou = true;
            getline(infile,line);
            break; 
        }
    }
    if(!encontrou){
        cout << "Output inesperado do Matlab" << endl;
        exit(0);
    }

    getline(infile,line);
    istringstream iss(line);
    iss >> valor;
    infile.close();
    remove("output.txt");
    return valor;
}

string removeSpaces(string input)
{
  input.erase(std::remove(input.begin(),input.end(),' '),input.end());
  return input;
}