#include <linux/unistd.h>
#include <linux/linkage.h>
#include <linux/syscalls.h>
#include <linux/time.h>
#include <linux/resource.h>

asmlinkage long sys_proc_prior(pid_t pid, int prior){
	int aux = prior;
	if(aux < -20){
		return 2;
	}
	else if(aux > 19){
		return 2;
	}
	else{
		int which = PRIO_PROCESS;
		int ret = sys_setpriority(which,pid,prior); //retorna 0 se deu certo e -1 se deu errado
		return ret;
	}
}
