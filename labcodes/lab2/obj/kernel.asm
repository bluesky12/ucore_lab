
bin/kernel:     file format elf32-i386


Disassembly of section .text:

c0100000 <kern_entry>:
.text
.globl kern_entry
kern_entry:
    # reload temperate gdt (second time) to remap all physical memory
    # virtual_addr 0~4G=linear_addr&physical_addr -KERNBASE~4G-KERNBASE 
    lgdt REALLOC(__gdtdesc)
c0100000:	0f 01 15 18 70 11 00 	lgdtl  0x117018
    movl $KERNEL_DS, %eax
c0100007:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
c010000c:	8e d8                	mov    %eax,%ds
    movw %ax, %es
c010000e:	8e c0                	mov    %eax,%es
    movw %ax, %ss
c0100010:	8e d0                	mov    %eax,%ss

    ljmp $KERNEL_CS, $relocated
c0100012:	ea 19 00 10 c0 08 00 	ljmp   $0x8,$0xc0100019

c0100019 <relocated>:

relocated:

    # set ebp, esp
    movl $0x0, %ebp
c0100019:	bd 00 00 00 00       	mov    $0x0,%ebp
    # the kernel stack region is from bootstack -- bootstacktop,
    # the kernel stack size is KSTACKSIZE (8KB)defined in memlayout.h
    movl $bootstacktop, %esp
c010001e:	bc 00 70 11 c0       	mov    $0xc0117000,%esp
    # now kernel stack is ready , call the first C function
    call kern_init
c0100023:	e8 02 00 00 00       	call   c010002a <kern_init>

c0100028 <spin>:

# should never get here
spin:
    jmp spin
c0100028:	eb fe                	jmp    c0100028 <spin>

c010002a <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
c010002a:	55                   	push   %ebp
c010002b:	89 e5                	mov    %esp,%ebp
c010002d:	83 ec 28             	sub    $0x28,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
c0100030:	ba c8 89 11 c0       	mov    $0xc01189c8,%edx
c0100035:	b8 36 7a 11 c0       	mov    $0xc0117a36,%eax
c010003a:	29 c2                	sub    %eax,%edx
c010003c:	89 d0                	mov    %edx,%eax
c010003e:	89 44 24 08          	mov    %eax,0x8(%esp)
c0100042:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c0100049:	00 
c010004a:	c7 04 24 36 7a 11 c0 	movl   $0xc0117a36,(%esp)
c0100051:	e8 e2 5e 00 00       	call   c0105f38 <memset>

    cons_init();                // init the console
c0100056:	e8 bf 15 00 00       	call   c010161a <cons_init>

    const char *message = "(THU.CST) os is loading ...";
c010005b:	c7 45 f4 e0 60 10 c0 	movl   $0xc01060e0,-0xc(%ebp)
    cprintf("%s\n\n", message);
c0100062:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100065:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100069:	c7 04 24 fc 60 10 c0 	movl   $0xc01060fc,(%esp)
c0100070:	e8 d7 02 00 00       	call   c010034c <cprintf>

    print_kerninfo();
c0100075:	e8 06 08 00 00       	call   c0100880 <print_kerninfo>

    grade_backtrace();
c010007a:	e8 8b 00 00 00       	call   c010010a <grade_backtrace>

    pmm_init();                 // init physical memory management
c010007f:	e8 c2 43 00 00       	call   c0104446 <pmm_init>

    pic_init();                 // init interrupt controller
c0100084:	e8 fa 16 00 00       	call   c0101783 <pic_init>
    idt_init();                 // init interrupt descriptor table
c0100089:	e8 72 18 00 00       	call   c0101900 <idt_init>

    clock_init();               // init clock interrupt
c010008e:	e8 3d 0d 00 00       	call   c0100dd0 <clock_init>
    intr_enable();              // enable irq interrupt
c0100093:	e8 59 16 00 00       	call   c01016f1 <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
c0100098:	e8 6d 01 00 00       	call   c010020a <lab1_switch_test>

    /* do nothing */
    while (1);
c010009d:	eb fe                	jmp    c010009d <kern_init+0x73>

c010009f <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
c010009f:	55                   	push   %ebp
c01000a0:	89 e5                	mov    %esp,%ebp
c01000a2:	83 ec 18             	sub    $0x18,%esp
    mon_backtrace(0, NULL, NULL);
c01000a5:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c01000ac:	00 
c01000ad:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c01000b4:	00 
c01000b5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
c01000bc:	e8 41 0c 00 00       	call   c0100d02 <mon_backtrace>
}
c01000c1:	c9                   	leave  
c01000c2:	c3                   	ret    

c01000c3 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
c01000c3:	55                   	push   %ebp
c01000c4:	89 e5                	mov    %esp,%ebp
c01000c6:	53                   	push   %ebx
c01000c7:	83 ec 14             	sub    $0x14,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
c01000ca:	8d 5d 0c             	lea    0xc(%ebp),%ebx
c01000cd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
c01000d0:	8d 55 08             	lea    0x8(%ebp),%edx
c01000d3:	8b 45 08             	mov    0x8(%ebp),%eax
c01000d6:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
c01000da:	89 4c 24 08          	mov    %ecx,0x8(%esp)
c01000de:	89 54 24 04          	mov    %edx,0x4(%esp)
c01000e2:	89 04 24             	mov    %eax,(%esp)
c01000e5:	e8 b5 ff ff ff       	call   c010009f <grade_backtrace2>
}
c01000ea:	83 c4 14             	add    $0x14,%esp
c01000ed:	5b                   	pop    %ebx
c01000ee:	5d                   	pop    %ebp
c01000ef:	c3                   	ret    

c01000f0 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
c01000f0:	55                   	push   %ebp
c01000f1:	89 e5                	mov    %esp,%ebp
c01000f3:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace1(arg0, arg2);
c01000f6:	8b 45 10             	mov    0x10(%ebp),%eax
c01000f9:	89 44 24 04          	mov    %eax,0x4(%esp)
c01000fd:	8b 45 08             	mov    0x8(%ebp),%eax
c0100100:	89 04 24             	mov    %eax,(%esp)
c0100103:	e8 bb ff ff ff       	call   c01000c3 <grade_backtrace1>
}
c0100108:	c9                   	leave  
c0100109:	c3                   	ret    

c010010a <grade_backtrace>:

void
grade_backtrace(void) {
c010010a:	55                   	push   %ebp
c010010b:	89 e5                	mov    %esp,%ebp
c010010d:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
c0100110:	b8 2a 00 10 c0       	mov    $0xc010002a,%eax
c0100115:	c7 44 24 08 00 00 ff 	movl   $0xffff0000,0x8(%esp)
c010011c:	ff 
c010011d:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100121:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
c0100128:	e8 c3 ff ff ff       	call   c01000f0 <grade_backtrace0>
}
c010012d:	c9                   	leave  
c010012e:	c3                   	ret    

c010012f <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
c010012f:	55                   	push   %ebp
c0100130:	89 e5                	mov    %esp,%ebp
c0100132:	83 ec 28             	sub    $0x28,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
c0100135:	8c 4d f6             	mov    %cs,-0xa(%ebp)
c0100138:	8c 5d f4             	mov    %ds,-0xc(%ebp)
c010013b:	8c 45 f2             	mov    %es,-0xe(%ebp)
c010013e:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
c0100141:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c0100145:	0f b7 c0             	movzwl %ax,%eax
c0100148:	83 e0 03             	and    $0x3,%eax
c010014b:	89 c2                	mov    %eax,%edx
c010014d:	a1 40 7a 11 c0       	mov    0xc0117a40,%eax
c0100152:	89 54 24 08          	mov    %edx,0x8(%esp)
c0100156:	89 44 24 04          	mov    %eax,0x4(%esp)
c010015a:	c7 04 24 01 61 10 c0 	movl   $0xc0106101,(%esp)
c0100161:	e8 e6 01 00 00       	call   c010034c <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
c0100166:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c010016a:	0f b7 d0             	movzwl %ax,%edx
c010016d:	a1 40 7a 11 c0       	mov    0xc0117a40,%eax
c0100172:	89 54 24 08          	mov    %edx,0x8(%esp)
c0100176:	89 44 24 04          	mov    %eax,0x4(%esp)
c010017a:	c7 04 24 0f 61 10 c0 	movl   $0xc010610f,(%esp)
c0100181:	e8 c6 01 00 00       	call   c010034c <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
c0100186:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
c010018a:	0f b7 d0             	movzwl %ax,%edx
c010018d:	a1 40 7a 11 c0       	mov    0xc0117a40,%eax
c0100192:	89 54 24 08          	mov    %edx,0x8(%esp)
c0100196:	89 44 24 04          	mov    %eax,0x4(%esp)
c010019a:	c7 04 24 1d 61 10 c0 	movl   $0xc010611d,(%esp)
c01001a1:	e8 a6 01 00 00       	call   c010034c <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
c01001a6:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c01001aa:	0f b7 d0             	movzwl %ax,%edx
c01001ad:	a1 40 7a 11 c0       	mov    0xc0117a40,%eax
c01001b2:	89 54 24 08          	mov    %edx,0x8(%esp)
c01001b6:	89 44 24 04          	mov    %eax,0x4(%esp)
c01001ba:	c7 04 24 2b 61 10 c0 	movl   $0xc010612b,(%esp)
c01001c1:	e8 86 01 00 00       	call   c010034c <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
c01001c6:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
c01001ca:	0f b7 d0             	movzwl %ax,%edx
c01001cd:	a1 40 7a 11 c0       	mov    0xc0117a40,%eax
c01001d2:	89 54 24 08          	mov    %edx,0x8(%esp)
c01001d6:	89 44 24 04          	mov    %eax,0x4(%esp)
c01001da:	c7 04 24 39 61 10 c0 	movl   $0xc0106139,(%esp)
c01001e1:	e8 66 01 00 00       	call   c010034c <cprintf>
    round ++;
c01001e6:	a1 40 7a 11 c0       	mov    0xc0117a40,%eax
c01001eb:	83 c0 01             	add    $0x1,%eax
c01001ee:	a3 40 7a 11 c0       	mov    %eax,0xc0117a40
}
c01001f3:	c9                   	leave  
c01001f4:	c3                   	ret    

c01001f5 <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
c01001f5:	55                   	push   %ebp
c01001f6:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
	asm volatile (
c01001f8:	83 ec 08             	sub    $0x8,%esp
c01001fb:	cd 78                	int    $0x78
c01001fd:	89 ec                	mov    %ebp,%esp
		    "int %0 \n"
		    "movl %%ebp, %%esp"
		    :
		    : "i"(T_SWITCH_TOU)
		);
}
c01001ff:	5d                   	pop    %ebp
c0100200:	c3                   	ret    

c0100201 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
c0100201:	55                   	push   %ebp
c0100202:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
	asm volatile (
c0100204:	cd 79                	int    $0x79
c0100206:	89 ec                	mov    %ebp,%esp
		    "int %0 \n"
		    "movl %%ebp, %%esp \n"
		    :
		    : "i"(T_SWITCH_TOK)
		);
}
c0100208:	5d                   	pop    %ebp
c0100209:	c3                   	ret    

c010020a <lab1_switch_test>:

static void
lab1_switch_test(void) {
c010020a:	55                   	push   %ebp
c010020b:	89 e5                	mov    %esp,%ebp
c010020d:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();
c0100210:	e8 1a ff ff ff       	call   c010012f <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
c0100215:	c7 04 24 48 61 10 c0 	movl   $0xc0106148,(%esp)
c010021c:	e8 2b 01 00 00       	call   c010034c <cprintf>
    lab1_switch_to_user();
c0100221:	e8 cf ff ff ff       	call   c01001f5 <lab1_switch_to_user>
    lab1_print_cur_status();
c0100226:	e8 04 ff ff ff       	call   c010012f <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
c010022b:	c7 04 24 68 61 10 c0 	movl   $0xc0106168,(%esp)
c0100232:	e8 15 01 00 00       	call   c010034c <cprintf>
    lab1_switch_to_kernel();
c0100237:	e8 c5 ff ff ff       	call   c0100201 <lab1_switch_to_kernel>
    lab1_print_cur_status();
c010023c:	e8 ee fe ff ff       	call   c010012f <lab1_print_cur_status>
}
c0100241:	c9                   	leave  
c0100242:	c3                   	ret    

c0100243 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
c0100243:	55                   	push   %ebp
c0100244:	89 e5                	mov    %esp,%ebp
c0100246:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
c0100249:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c010024d:	74 13                	je     c0100262 <readline+0x1f>
        cprintf("%s", prompt);
c010024f:	8b 45 08             	mov    0x8(%ebp),%eax
c0100252:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100256:	c7 04 24 87 61 10 c0 	movl   $0xc0106187,(%esp)
c010025d:	e8 ea 00 00 00       	call   c010034c <cprintf>
    }
    int i = 0, c;
c0100262:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
c0100269:	e8 66 01 00 00       	call   c01003d4 <getchar>
c010026e:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
c0100271:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0100275:	79 07                	jns    c010027e <readline+0x3b>
            return NULL;
c0100277:	b8 00 00 00 00       	mov    $0x0,%eax
c010027c:	eb 79                	jmp    c01002f7 <readline+0xb4>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
c010027e:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
c0100282:	7e 28                	jle    c01002ac <readline+0x69>
c0100284:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
c010028b:	7f 1f                	jg     c01002ac <readline+0x69>
            cputchar(c);
c010028d:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0100290:	89 04 24             	mov    %eax,(%esp)
c0100293:	e8 da 00 00 00       	call   c0100372 <cputchar>
            buf[i ++] = c;
c0100298:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010029b:	8d 50 01             	lea    0x1(%eax),%edx
c010029e:	89 55 f4             	mov    %edx,-0xc(%ebp)
c01002a1:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01002a4:	88 90 60 7a 11 c0    	mov    %dl,-0x3fee85a0(%eax)
c01002aa:	eb 46                	jmp    c01002f2 <readline+0xaf>
        }
        else if (c == '\b' && i > 0) {
c01002ac:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
c01002b0:	75 17                	jne    c01002c9 <readline+0x86>
c01002b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01002b6:	7e 11                	jle    c01002c9 <readline+0x86>
            cputchar(c);
c01002b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01002bb:	89 04 24             	mov    %eax,(%esp)
c01002be:	e8 af 00 00 00       	call   c0100372 <cputchar>
            i --;
c01002c3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
c01002c7:	eb 29                	jmp    c01002f2 <readline+0xaf>
        }
        else if (c == '\n' || c == '\r') {
c01002c9:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
c01002cd:	74 06                	je     c01002d5 <readline+0x92>
c01002cf:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
c01002d3:	75 1d                	jne    c01002f2 <readline+0xaf>
            cputchar(c);
c01002d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01002d8:	89 04 24             	mov    %eax,(%esp)
c01002db:	e8 92 00 00 00       	call   c0100372 <cputchar>
            buf[i] = '\0';
c01002e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01002e3:	05 60 7a 11 c0       	add    $0xc0117a60,%eax
c01002e8:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
c01002eb:	b8 60 7a 11 c0       	mov    $0xc0117a60,%eax
c01002f0:	eb 05                	jmp    c01002f7 <readline+0xb4>
        }
    }
c01002f2:	e9 72 ff ff ff       	jmp    c0100269 <readline+0x26>
}
c01002f7:	c9                   	leave  
c01002f8:	c3                   	ret    

c01002f9 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
c01002f9:	55                   	push   %ebp
c01002fa:	89 e5                	mov    %esp,%ebp
c01002fc:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
c01002ff:	8b 45 08             	mov    0x8(%ebp),%eax
c0100302:	89 04 24             	mov    %eax,(%esp)
c0100305:	e8 3c 13 00 00       	call   c0101646 <cons_putc>
    (*cnt) ++;
c010030a:	8b 45 0c             	mov    0xc(%ebp),%eax
c010030d:	8b 00                	mov    (%eax),%eax
c010030f:	8d 50 01             	lea    0x1(%eax),%edx
c0100312:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100315:	89 10                	mov    %edx,(%eax)
}
c0100317:	c9                   	leave  
c0100318:	c3                   	ret    

c0100319 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
c0100319:	55                   	push   %ebp
c010031a:	89 e5                	mov    %esp,%ebp
c010031c:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
c010031f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
c0100326:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100329:	89 44 24 0c          	mov    %eax,0xc(%esp)
c010032d:	8b 45 08             	mov    0x8(%ebp),%eax
c0100330:	89 44 24 08          	mov    %eax,0x8(%esp)
c0100334:	8d 45 f4             	lea    -0xc(%ebp),%eax
c0100337:	89 44 24 04          	mov    %eax,0x4(%esp)
c010033b:	c7 04 24 f9 02 10 c0 	movl   $0xc01002f9,(%esp)
c0100342:	e8 0a 54 00 00       	call   c0105751 <vprintfmt>
    return cnt;
c0100347:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c010034a:	c9                   	leave  
c010034b:	c3                   	ret    

c010034c <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
c010034c:	55                   	push   %ebp
c010034d:	89 e5                	mov    %esp,%ebp
c010034f:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
c0100352:	8d 45 0c             	lea    0xc(%ebp),%eax
c0100355:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
c0100358:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010035b:	89 44 24 04          	mov    %eax,0x4(%esp)
c010035f:	8b 45 08             	mov    0x8(%ebp),%eax
c0100362:	89 04 24             	mov    %eax,(%esp)
c0100365:	e8 af ff ff ff       	call   c0100319 <vcprintf>
c010036a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
c010036d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0100370:	c9                   	leave  
c0100371:	c3                   	ret    

c0100372 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
c0100372:	55                   	push   %ebp
c0100373:	89 e5                	mov    %esp,%ebp
c0100375:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
c0100378:	8b 45 08             	mov    0x8(%ebp),%eax
c010037b:	89 04 24             	mov    %eax,(%esp)
c010037e:	e8 c3 12 00 00       	call   c0101646 <cons_putc>
}
c0100383:	c9                   	leave  
c0100384:	c3                   	ret    

c0100385 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
c0100385:	55                   	push   %ebp
c0100386:	89 e5                	mov    %esp,%ebp
c0100388:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
c010038b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
c0100392:	eb 13                	jmp    c01003a7 <cputs+0x22>
        cputch(c, &cnt);
c0100394:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
c0100398:	8d 55 f0             	lea    -0x10(%ebp),%edx
c010039b:	89 54 24 04          	mov    %edx,0x4(%esp)
c010039f:	89 04 24             	mov    %eax,(%esp)
c01003a2:	e8 52 ff ff ff       	call   c01002f9 <cputch>
 * */
int
cputs(const char *str) {
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
c01003a7:	8b 45 08             	mov    0x8(%ebp),%eax
c01003aa:	8d 50 01             	lea    0x1(%eax),%edx
c01003ad:	89 55 08             	mov    %edx,0x8(%ebp)
c01003b0:	0f b6 00             	movzbl (%eax),%eax
c01003b3:	88 45 f7             	mov    %al,-0x9(%ebp)
c01003b6:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
c01003ba:	75 d8                	jne    c0100394 <cputs+0xf>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
c01003bc:	8d 45 f0             	lea    -0x10(%ebp),%eax
c01003bf:	89 44 24 04          	mov    %eax,0x4(%esp)
c01003c3:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
c01003ca:	e8 2a ff ff ff       	call   c01002f9 <cputch>
    return cnt;
c01003cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
c01003d2:	c9                   	leave  
c01003d3:	c3                   	ret    

c01003d4 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
c01003d4:	55                   	push   %ebp
c01003d5:	89 e5                	mov    %esp,%ebp
c01003d7:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
c01003da:	e8 a3 12 00 00       	call   c0101682 <cons_getc>
c01003df:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01003e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01003e6:	74 f2                	je     c01003da <getchar+0x6>
        /* do nothing */;
    return c;
c01003e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c01003eb:	c9                   	leave  
c01003ec:	c3                   	ret    

c01003ed <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
c01003ed:	55                   	push   %ebp
c01003ee:	89 e5                	mov    %esp,%ebp
c01003f0:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
c01003f3:	8b 45 0c             	mov    0xc(%ebp),%eax
c01003f6:	8b 00                	mov    (%eax),%eax
c01003f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
c01003fb:	8b 45 10             	mov    0x10(%ebp),%eax
c01003fe:	8b 00                	mov    (%eax),%eax
c0100400:	89 45 f8             	mov    %eax,-0x8(%ebp)
c0100403:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
c010040a:	e9 d2 00 00 00       	jmp    c01004e1 <stab_binsearch+0xf4>
        int true_m = (l + r) / 2, m = true_m;
c010040f:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0100412:	8b 55 fc             	mov    -0x4(%ebp),%edx
c0100415:	01 d0                	add    %edx,%eax
c0100417:	89 c2                	mov    %eax,%edx
c0100419:	c1 ea 1f             	shr    $0x1f,%edx
c010041c:	01 d0                	add    %edx,%eax
c010041e:	d1 f8                	sar    %eax
c0100420:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0100423:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0100426:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
c0100429:	eb 04                	jmp    c010042f <stab_binsearch+0x42>
            m --;
c010042b:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)

    while (l <= r) {
        int true_m = (l + r) / 2, m = true_m;

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
c010042f:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0100432:	3b 45 fc             	cmp    -0x4(%ebp),%eax
c0100435:	7c 1f                	jl     c0100456 <stab_binsearch+0x69>
c0100437:	8b 55 f0             	mov    -0x10(%ebp),%edx
c010043a:	89 d0                	mov    %edx,%eax
c010043c:	01 c0                	add    %eax,%eax
c010043e:	01 d0                	add    %edx,%eax
c0100440:	c1 e0 02             	shl    $0x2,%eax
c0100443:	89 c2                	mov    %eax,%edx
c0100445:	8b 45 08             	mov    0x8(%ebp),%eax
c0100448:	01 d0                	add    %edx,%eax
c010044a:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c010044e:	0f b6 c0             	movzbl %al,%eax
c0100451:	3b 45 14             	cmp    0x14(%ebp),%eax
c0100454:	75 d5                	jne    c010042b <stab_binsearch+0x3e>
            m --;
        }
        if (m < l) {    // no match in [l, m]
c0100456:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0100459:	3b 45 fc             	cmp    -0x4(%ebp),%eax
c010045c:	7d 0b                	jge    c0100469 <stab_binsearch+0x7c>
            l = true_m + 1;
c010045e:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0100461:	83 c0 01             	add    $0x1,%eax
c0100464:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
c0100467:	eb 78                	jmp    c01004e1 <stab_binsearch+0xf4>
        }

        // actual binary search
        any_matches = 1;
c0100469:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
c0100470:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0100473:	89 d0                	mov    %edx,%eax
c0100475:	01 c0                	add    %eax,%eax
c0100477:	01 d0                	add    %edx,%eax
c0100479:	c1 e0 02             	shl    $0x2,%eax
c010047c:	89 c2                	mov    %eax,%edx
c010047e:	8b 45 08             	mov    0x8(%ebp),%eax
c0100481:	01 d0                	add    %edx,%eax
c0100483:	8b 40 08             	mov    0x8(%eax),%eax
c0100486:	3b 45 18             	cmp    0x18(%ebp),%eax
c0100489:	73 13                	jae    c010049e <stab_binsearch+0xb1>
            *region_left = m;
c010048b:	8b 45 0c             	mov    0xc(%ebp),%eax
c010048e:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0100491:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
c0100493:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0100496:	83 c0 01             	add    $0x1,%eax
c0100499:	89 45 fc             	mov    %eax,-0x4(%ebp)
c010049c:	eb 43                	jmp    c01004e1 <stab_binsearch+0xf4>
        } else if (stabs[m].n_value > addr) {
c010049e:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01004a1:	89 d0                	mov    %edx,%eax
c01004a3:	01 c0                	add    %eax,%eax
c01004a5:	01 d0                	add    %edx,%eax
c01004a7:	c1 e0 02             	shl    $0x2,%eax
c01004aa:	89 c2                	mov    %eax,%edx
c01004ac:	8b 45 08             	mov    0x8(%ebp),%eax
c01004af:	01 d0                	add    %edx,%eax
c01004b1:	8b 40 08             	mov    0x8(%eax),%eax
c01004b4:	3b 45 18             	cmp    0x18(%ebp),%eax
c01004b7:	76 16                	jbe    c01004cf <stab_binsearch+0xe2>
            *region_right = m - 1;
c01004b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01004bc:	8d 50 ff             	lea    -0x1(%eax),%edx
c01004bf:	8b 45 10             	mov    0x10(%ebp),%eax
c01004c2:	89 10                	mov    %edx,(%eax)
            r = m - 1;
c01004c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01004c7:	83 e8 01             	sub    $0x1,%eax
c01004ca:	89 45 f8             	mov    %eax,-0x8(%ebp)
c01004cd:	eb 12                	jmp    c01004e1 <stab_binsearch+0xf4>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
c01004cf:	8b 45 0c             	mov    0xc(%ebp),%eax
c01004d2:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01004d5:	89 10                	mov    %edx,(%eax)
            l = m;
c01004d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01004da:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
c01004dd:	83 45 18 01          	addl   $0x1,0x18(%ebp)
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
    int l = *region_left, r = *region_right, any_matches = 0;

    while (l <= r) {
c01004e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01004e4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
c01004e7:	0f 8e 22 ff ff ff    	jle    c010040f <stab_binsearch+0x22>
            l = m;
            addr ++;
        }
    }

    if (!any_matches) {
c01004ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01004f1:	75 0f                	jne    c0100502 <stab_binsearch+0x115>
        *region_right = *region_left - 1;
c01004f3:	8b 45 0c             	mov    0xc(%ebp),%eax
c01004f6:	8b 00                	mov    (%eax),%eax
c01004f8:	8d 50 ff             	lea    -0x1(%eax),%edx
c01004fb:	8b 45 10             	mov    0x10(%ebp),%eax
c01004fe:	89 10                	mov    %edx,(%eax)
c0100500:	eb 3f                	jmp    c0100541 <stab_binsearch+0x154>
    }
    else {
        // find rightmost region containing 'addr'
        l = *region_right;
c0100502:	8b 45 10             	mov    0x10(%ebp),%eax
c0100505:	8b 00                	mov    (%eax),%eax
c0100507:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
c010050a:	eb 04                	jmp    c0100510 <stab_binsearch+0x123>
c010050c:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
c0100510:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100513:	8b 00                	mov    (%eax),%eax
c0100515:	3b 45 fc             	cmp    -0x4(%ebp),%eax
c0100518:	7d 1f                	jge    c0100539 <stab_binsearch+0x14c>
c010051a:	8b 55 fc             	mov    -0x4(%ebp),%edx
c010051d:	89 d0                	mov    %edx,%eax
c010051f:	01 c0                	add    %eax,%eax
c0100521:	01 d0                	add    %edx,%eax
c0100523:	c1 e0 02             	shl    $0x2,%eax
c0100526:	89 c2                	mov    %eax,%edx
c0100528:	8b 45 08             	mov    0x8(%ebp),%eax
c010052b:	01 d0                	add    %edx,%eax
c010052d:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c0100531:	0f b6 c0             	movzbl %al,%eax
c0100534:	3b 45 14             	cmp    0x14(%ebp),%eax
c0100537:	75 d3                	jne    c010050c <stab_binsearch+0x11f>
            /* do nothing */;
        *region_left = l;
c0100539:	8b 45 0c             	mov    0xc(%ebp),%eax
c010053c:	8b 55 fc             	mov    -0x4(%ebp),%edx
c010053f:	89 10                	mov    %edx,(%eax)
    }
}
c0100541:	c9                   	leave  
c0100542:	c3                   	ret    

c0100543 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
c0100543:	55                   	push   %ebp
c0100544:	89 e5                	mov    %esp,%ebp
c0100546:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
c0100549:	8b 45 0c             	mov    0xc(%ebp),%eax
c010054c:	c7 00 8c 61 10 c0    	movl   $0xc010618c,(%eax)
    info->eip_line = 0;
c0100552:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100555:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
c010055c:	8b 45 0c             	mov    0xc(%ebp),%eax
c010055f:	c7 40 08 8c 61 10 c0 	movl   $0xc010618c,0x8(%eax)
    info->eip_fn_namelen = 9;
c0100566:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100569:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
c0100570:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100573:	8b 55 08             	mov    0x8(%ebp),%edx
c0100576:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
c0100579:	8b 45 0c             	mov    0xc(%ebp),%eax
c010057c:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
c0100583:	c7 45 f4 e0 73 10 c0 	movl   $0xc01073e0,-0xc(%ebp)
    stab_end = __STAB_END__;
c010058a:	c7 45 f0 a4 21 11 c0 	movl   $0xc01121a4,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
c0100591:	c7 45 ec a5 21 11 c0 	movl   $0xc01121a5,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
c0100598:	c7 45 e8 32 4c 11 c0 	movl   $0xc0114c32,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
c010059f:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01005a2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
c01005a5:	76 0d                	jbe    c01005b4 <debuginfo_eip+0x71>
c01005a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01005aa:	83 e8 01             	sub    $0x1,%eax
c01005ad:	0f b6 00             	movzbl (%eax),%eax
c01005b0:	84 c0                	test   %al,%al
c01005b2:	74 0a                	je     c01005be <debuginfo_eip+0x7b>
        return -1;
c01005b4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c01005b9:	e9 c0 02 00 00       	jmp    c010087e <debuginfo_eip+0x33b>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
c01005be:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
c01005c5:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01005c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01005cb:	29 c2                	sub    %eax,%edx
c01005cd:	89 d0                	mov    %edx,%eax
c01005cf:	c1 f8 02             	sar    $0x2,%eax
c01005d2:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
c01005d8:	83 e8 01             	sub    $0x1,%eax
c01005db:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
c01005de:	8b 45 08             	mov    0x8(%ebp),%eax
c01005e1:	89 44 24 10          	mov    %eax,0x10(%esp)
c01005e5:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
c01005ec:	00 
c01005ed:	8d 45 e0             	lea    -0x20(%ebp),%eax
c01005f0:	89 44 24 08          	mov    %eax,0x8(%esp)
c01005f4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
c01005f7:	89 44 24 04          	mov    %eax,0x4(%esp)
c01005fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01005fe:	89 04 24             	mov    %eax,(%esp)
c0100601:	e8 e7 fd ff ff       	call   c01003ed <stab_binsearch>
    if (lfile == 0)
c0100606:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0100609:	85 c0                	test   %eax,%eax
c010060b:	75 0a                	jne    c0100617 <debuginfo_eip+0xd4>
        return -1;
c010060d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c0100612:	e9 67 02 00 00       	jmp    c010087e <debuginfo_eip+0x33b>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
c0100617:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010061a:	89 45 dc             	mov    %eax,-0x24(%ebp)
c010061d:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0100620:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
c0100623:	8b 45 08             	mov    0x8(%ebp),%eax
c0100626:	89 44 24 10          	mov    %eax,0x10(%esp)
c010062a:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
c0100631:	00 
c0100632:	8d 45 d8             	lea    -0x28(%ebp),%eax
c0100635:	89 44 24 08          	mov    %eax,0x8(%esp)
c0100639:	8d 45 dc             	lea    -0x24(%ebp),%eax
c010063c:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100640:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100643:	89 04 24             	mov    %eax,(%esp)
c0100646:	e8 a2 fd ff ff       	call   c01003ed <stab_binsearch>

    if (lfun <= rfun) {
c010064b:	8b 55 dc             	mov    -0x24(%ebp),%edx
c010064e:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0100651:	39 c2                	cmp    %eax,%edx
c0100653:	7f 7c                	jg     c01006d1 <debuginfo_eip+0x18e>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
c0100655:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100658:	89 c2                	mov    %eax,%edx
c010065a:	89 d0                	mov    %edx,%eax
c010065c:	01 c0                	add    %eax,%eax
c010065e:	01 d0                	add    %edx,%eax
c0100660:	c1 e0 02             	shl    $0x2,%eax
c0100663:	89 c2                	mov    %eax,%edx
c0100665:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100668:	01 d0                	add    %edx,%eax
c010066a:	8b 10                	mov    (%eax),%edx
c010066c:	8b 4d e8             	mov    -0x18(%ebp),%ecx
c010066f:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0100672:	29 c1                	sub    %eax,%ecx
c0100674:	89 c8                	mov    %ecx,%eax
c0100676:	39 c2                	cmp    %eax,%edx
c0100678:	73 22                	jae    c010069c <debuginfo_eip+0x159>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
c010067a:	8b 45 dc             	mov    -0x24(%ebp),%eax
c010067d:	89 c2                	mov    %eax,%edx
c010067f:	89 d0                	mov    %edx,%eax
c0100681:	01 c0                	add    %eax,%eax
c0100683:	01 d0                	add    %edx,%eax
c0100685:	c1 e0 02             	shl    $0x2,%eax
c0100688:	89 c2                	mov    %eax,%edx
c010068a:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010068d:	01 d0                	add    %edx,%eax
c010068f:	8b 10                	mov    (%eax),%edx
c0100691:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0100694:	01 c2                	add    %eax,%edx
c0100696:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100699:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
c010069c:	8b 45 dc             	mov    -0x24(%ebp),%eax
c010069f:	89 c2                	mov    %eax,%edx
c01006a1:	89 d0                	mov    %edx,%eax
c01006a3:	01 c0                	add    %eax,%eax
c01006a5:	01 d0                	add    %edx,%eax
c01006a7:	c1 e0 02             	shl    $0x2,%eax
c01006aa:	89 c2                	mov    %eax,%edx
c01006ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01006af:	01 d0                	add    %edx,%eax
c01006b1:	8b 50 08             	mov    0x8(%eax),%edx
c01006b4:	8b 45 0c             	mov    0xc(%ebp),%eax
c01006b7:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
c01006ba:	8b 45 0c             	mov    0xc(%ebp),%eax
c01006bd:	8b 40 10             	mov    0x10(%eax),%eax
c01006c0:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
c01006c3:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01006c6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
c01006c9:	8b 45 d8             	mov    -0x28(%ebp),%eax
c01006cc:	89 45 d0             	mov    %eax,-0x30(%ebp)
c01006cf:	eb 15                	jmp    c01006e6 <debuginfo_eip+0x1a3>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
c01006d1:	8b 45 0c             	mov    0xc(%ebp),%eax
c01006d4:	8b 55 08             	mov    0x8(%ebp),%edx
c01006d7:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
c01006da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01006dd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
c01006e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01006e3:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
c01006e6:	8b 45 0c             	mov    0xc(%ebp),%eax
c01006e9:	8b 40 08             	mov    0x8(%eax),%eax
c01006ec:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
c01006f3:	00 
c01006f4:	89 04 24             	mov    %eax,(%esp)
c01006f7:	e8 b0 56 00 00       	call   c0105dac <strfind>
c01006fc:	89 c2                	mov    %eax,%edx
c01006fe:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100701:	8b 40 08             	mov    0x8(%eax),%eax
c0100704:	29 c2                	sub    %eax,%edx
c0100706:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100709:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
c010070c:	8b 45 08             	mov    0x8(%ebp),%eax
c010070f:	89 44 24 10          	mov    %eax,0x10(%esp)
c0100713:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
c010071a:	00 
c010071b:	8d 45 d0             	lea    -0x30(%ebp),%eax
c010071e:	89 44 24 08          	mov    %eax,0x8(%esp)
c0100722:	8d 45 d4             	lea    -0x2c(%ebp),%eax
c0100725:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100729:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010072c:	89 04 24             	mov    %eax,(%esp)
c010072f:	e8 b9 fc ff ff       	call   c01003ed <stab_binsearch>
    if (lline <= rline) {
c0100734:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0100737:	8b 45 d0             	mov    -0x30(%ebp),%eax
c010073a:	39 c2                	cmp    %eax,%edx
c010073c:	7f 24                	jg     c0100762 <debuginfo_eip+0x21f>
        info->eip_line = stabs[rline].n_desc;
c010073e:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0100741:	89 c2                	mov    %eax,%edx
c0100743:	89 d0                	mov    %edx,%eax
c0100745:	01 c0                	add    %eax,%eax
c0100747:	01 d0                	add    %edx,%eax
c0100749:	c1 e0 02             	shl    $0x2,%eax
c010074c:	89 c2                	mov    %eax,%edx
c010074e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100751:	01 d0                	add    %edx,%eax
c0100753:	0f b7 40 06          	movzwl 0x6(%eax),%eax
c0100757:	0f b7 d0             	movzwl %ax,%edx
c010075a:	8b 45 0c             	mov    0xc(%ebp),%eax
c010075d:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
c0100760:	eb 13                	jmp    c0100775 <debuginfo_eip+0x232>
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
    if (lline <= rline) {
        info->eip_line = stabs[rline].n_desc;
    } else {
        return -1;
c0100762:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c0100767:	e9 12 01 00 00       	jmp    c010087e <debuginfo_eip+0x33b>
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
c010076c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c010076f:	83 e8 01             	sub    $0x1,%eax
c0100772:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
c0100775:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010077b:	39 c2                	cmp    %eax,%edx
c010077d:	7c 56                	jl     c01007d5 <debuginfo_eip+0x292>
           && stabs[lline].n_type != N_SOL
c010077f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100782:	89 c2                	mov    %eax,%edx
c0100784:	89 d0                	mov    %edx,%eax
c0100786:	01 c0                	add    %eax,%eax
c0100788:	01 d0                	add    %edx,%eax
c010078a:	c1 e0 02             	shl    $0x2,%eax
c010078d:	89 c2                	mov    %eax,%edx
c010078f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100792:	01 d0                	add    %edx,%eax
c0100794:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c0100798:	3c 84                	cmp    $0x84,%al
c010079a:	74 39                	je     c01007d5 <debuginfo_eip+0x292>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
c010079c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c010079f:	89 c2                	mov    %eax,%edx
c01007a1:	89 d0                	mov    %edx,%eax
c01007a3:	01 c0                	add    %eax,%eax
c01007a5:	01 d0                	add    %edx,%eax
c01007a7:	c1 e0 02             	shl    $0x2,%eax
c01007aa:	89 c2                	mov    %eax,%edx
c01007ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01007af:	01 d0                	add    %edx,%eax
c01007b1:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c01007b5:	3c 64                	cmp    $0x64,%al
c01007b7:	75 b3                	jne    c010076c <debuginfo_eip+0x229>
c01007b9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c01007bc:	89 c2                	mov    %eax,%edx
c01007be:	89 d0                	mov    %edx,%eax
c01007c0:	01 c0                	add    %eax,%eax
c01007c2:	01 d0                	add    %edx,%eax
c01007c4:	c1 e0 02             	shl    $0x2,%eax
c01007c7:	89 c2                	mov    %eax,%edx
c01007c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01007cc:	01 d0                	add    %edx,%eax
c01007ce:	8b 40 08             	mov    0x8(%eax),%eax
c01007d1:	85 c0                	test   %eax,%eax
c01007d3:	74 97                	je     c010076c <debuginfo_eip+0x229>
        lline --;
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
c01007d5:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c01007d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01007db:	39 c2                	cmp    %eax,%edx
c01007dd:	7c 46                	jl     c0100825 <debuginfo_eip+0x2e2>
c01007df:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c01007e2:	89 c2                	mov    %eax,%edx
c01007e4:	89 d0                	mov    %edx,%eax
c01007e6:	01 c0                	add    %eax,%eax
c01007e8:	01 d0                	add    %edx,%eax
c01007ea:	c1 e0 02             	shl    $0x2,%eax
c01007ed:	89 c2                	mov    %eax,%edx
c01007ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01007f2:	01 d0                	add    %edx,%eax
c01007f4:	8b 10                	mov    (%eax),%edx
c01007f6:	8b 4d e8             	mov    -0x18(%ebp),%ecx
c01007f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01007fc:	29 c1                	sub    %eax,%ecx
c01007fe:	89 c8                	mov    %ecx,%eax
c0100800:	39 c2                	cmp    %eax,%edx
c0100802:	73 21                	jae    c0100825 <debuginfo_eip+0x2e2>
        info->eip_file = stabstr + stabs[lline].n_strx;
c0100804:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100807:	89 c2                	mov    %eax,%edx
c0100809:	89 d0                	mov    %edx,%eax
c010080b:	01 c0                	add    %eax,%eax
c010080d:	01 d0                	add    %edx,%eax
c010080f:	c1 e0 02             	shl    $0x2,%eax
c0100812:	89 c2                	mov    %eax,%edx
c0100814:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100817:	01 d0                	add    %edx,%eax
c0100819:	8b 10                	mov    (%eax),%edx
c010081b:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010081e:	01 c2                	add    %eax,%edx
c0100820:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100823:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
c0100825:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0100828:	8b 45 d8             	mov    -0x28(%ebp),%eax
c010082b:	39 c2                	cmp    %eax,%edx
c010082d:	7d 4a                	jge    c0100879 <debuginfo_eip+0x336>
        for (lline = lfun + 1;
c010082f:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100832:	83 c0 01             	add    $0x1,%eax
c0100835:	89 45 d4             	mov    %eax,-0x2c(%ebp)
c0100838:	eb 18                	jmp    c0100852 <debuginfo_eip+0x30f>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
c010083a:	8b 45 0c             	mov    0xc(%ebp),%eax
c010083d:	8b 40 14             	mov    0x14(%eax),%eax
c0100840:	8d 50 01             	lea    0x1(%eax),%edx
c0100843:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100846:	89 50 14             	mov    %edx,0x14(%eax)
    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
c0100849:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c010084c:	83 c0 01             	add    $0x1,%eax
c010084f:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
c0100852:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0100855:	8b 45 d8             	mov    -0x28(%ebp),%eax
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
c0100858:	39 c2                	cmp    %eax,%edx
c010085a:	7d 1d                	jge    c0100879 <debuginfo_eip+0x336>
             lline < rfun && stabs[lline].n_type == N_PSYM;
c010085c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c010085f:	89 c2                	mov    %eax,%edx
c0100861:	89 d0                	mov    %edx,%eax
c0100863:	01 c0                	add    %eax,%eax
c0100865:	01 d0                	add    %edx,%eax
c0100867:	c1 e0 02             	shl    $0x2,%eax
c010086a:	89 c2                	mov    %eax,%edx
c010086c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010086f:	01 d0                	add    %edx,%eax
c0100871:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c0100875:	3c a0                	cmp    $0xa0,%al
c0100877:	74 c1                	je     c010083a <debuginfo_eip+0x2f7>
             lline ++) {
            info->eip_fn_narg ++;
        }
    }
    return 0;
c0100879:	b8 00 00 00 00       	mov    $0x0,%eax
}
c010087e:	c9                   	leave  
c010087f:	c3                   	ret    

c0100880 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
c0100880:	55                   	push   %ebp
c0100881:	89 e5                	mov    %esp,%ebp
c0100883:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
c0100886:	c7 04 24 96 61 10 c0 	movl   $0xc0106196,(%esp)
c010088d:	e8 ba fa ff ff       	call   c010034c <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
c0100892:	c7 44 24 04 2a 00 10 	movl   $0xc010002a,0x4(%esp)
c0100899:	c0 
c010089a:	c7 04 24 af 61 10 c0 	movl   $0xc01061af,(%esp)
c01008a1:	e8 a6 fa ff ff       	call   c010034c <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
c01008a6:	c7 44 24 04 c1 60 10 	movl   $0xc01060c1,0x4(%esp)
c01008ad:	c0 
c01008ae:	c7 04 24 c7 61 10 c0 	movl   $0xc01061c7,(%esp)
c01008b5:	e8 92 fa ff ff       	call   c010034c <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
c01008ba:	c7 44 24 04 36 7a 11 	movl   $0xc0117a36,0x4(%esp)
c01008c1:	c0 
c01008c2:	c7 04 24 df 61 10 c0 	movl   $0xc01061df,(%esp)
c01008c9:	e8 7e fa ff ff       	call   c010034c <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
c01008ce:	c7 44 24 04 c8 89 11 	movl   $0xc01189c8,0x4(%esp)
c01008d5:	c0 
c01008d6:	c7 04 24 f7 61 10 c0 	movl   $0xc01061f7,(%esp)
c01008dd:	e8 6a fa ff ff       	call   c010034c <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
c01008e2:	b8 c8 89 11 c0       	mov    $0xc01189c8,%eax
c01008e7:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
c01008ed:	b8 2a 00 10 c0       	mov    $0xc010002a,%eax
c01008f2:	29 c2                	sub    %eax,%edx
c01008f4:	89 d0                	mov    %edx,%eax
c01008f6:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
c01008fc:	85 c0                	test   %eax,%eax
c01008fe:	0f 48 c2             	cmovs  %edx,%eax
c0100901:	c1 f8 0a             	sar    $0xa,%eax
c0100904:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100908:	c7 04 24 10 62 10 c0 	movl   $0xc0106210,(%esp)
c010090f:	e8 38 fa ff ff       	call   c010034c <cprintf>
}
c0100914:	c9                   	leave  
c0100915:	c3                   	ret    

c0100916 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
c0100916:	55                   	push   %ebp
c0100917:	89 e5                	mov    %esp,%ebp
c0100919:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
c010091f:	8d 45 dc             	lea    -0x24(%ebp),%eax
c0100922:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100926:	8b 45 08             	mov    0x8(%ebp),%eax
c0100929:	89 04 24             	mov    %eax,(%esp)
c010092c:	e8 12 fc ff ff       	call   c0100543 <debuginfo_eip>
c0100931:	85 c0                	test   %eax,%eax
c0100933:	74 15                	je     c010094a <print_debuginfo+0x34>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
c0100935:	8b 45 08             	mov    0x8(%ebp),%eax
c0100938:	89 44 24 04          	mov    %eax,0x4(%esp)
c010093c:	c7 04 24 3a 62 10 c0 	movl   $0xc010623a,(%esp)
c0100943:	e8 04 fa ff ff       	call   c010034c <cprintf>
c0100948:	eb 6d                	jmp    c01009b7 <print_debuginfo+0xa1>
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
c010094a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0100951:	eb 1c                	jmp    c010096f <print_debuginfo+0x59>
            fnname[j] = info.eip_fn_name[j];
c0100953:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0100956:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100959:	01 d0                	add    %edx,%eax
c010095b:	0f b6 00             	movzbl (%eax),%eax
c010095e:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
c0100964:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100967:	01 ca                	add    %ecx,%edx
c0100969:	88 02                	mov    %al,(%edx)
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
c010096b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c010096f:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0100972:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c0100975:	7f dc                	jg     c0100953 <print_debuginfo+0x3d>
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
c0100977:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
c010097d:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100980:	01 d0                	add    %edx,%eax
c0100982:	c6 00 00             	movb   $0x0,(%eax)
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
c0100985:	8b 45 ec             	mov    -0x14(%ebp),%eax
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
c0100988:	8b 55 08             	mov    0x8(%ebp),%edx
c010098b:	89 d1                	mov    %edx,%ecx
c010098d:	29 c1                	sub    %eax,%ecx
c010098f:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0100992:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100995:	89 4c 24 10          	mov    %ecx,0x10(%esp)
c0100999:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
c010099f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
c01009a3:	89 54 24 08          	mov    %edx,0x8(%esp)
c01009a7:	89 44 24 04          	mov    %eax,0x4(%esp)
c01009ab:	c7 04 24 56 62 10 c0 	movl   $0xc0106256,(%esp)
c01009b2:	e8 95 f9 ff ff       	call   c010034c <cprintf>
                fnname, eip - info.eip_fn_addr);
    }
}
c01009b7:	c9                   	leave  
c01009b8:	c3                   	ret    

c01009b9 <read_eip>:

static __noinline uint32_t
read_eip(void) {
c01009b9:	55                   	push   %ebp
c01009ba:	89 e5                	mov    %esp,%ebp
c01009bc:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
c01009bf:	8b 45 04             	mov    0x4(%ebp),%eax
c01009c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
c01009c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c01009c8:	c9                   	leave  
c01009c9:	c3                   	ret    

c01009ca <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
c01009ca:	55                   	push   %ebp
c01009cb:	89 e5                	mov    %esp,%ebp
c01009cd:	53                   	push   %ebx
c01009ce:	83 ec 44             	sub    $0x44,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
c01009d1:	89 e8                	mov    %ebp,%eax
c01009d3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    return ebp;
c01009d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */

	uint32_t ebp= read_ebp(), eip= read_eip();
c01009d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01009dc:	e8 d8 ff ff ff       	call   c01009b9 <read_eip>
c01009e1:	89 45 f0             	mov    %eax,-0x10(%ebp)

	int i=0;
c01009e4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	while (ebp!=0 && (i++)<STACKFRAME_DEPTH )
c01009eb:	e9 b9 00 00 00       	jmp    c0100aa9 <print_stackframe+0xdf>
	{
		uint32_t args[4]={0};
c01009f0:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
c01009f7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c01009fe:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
c0100a05:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		asm volatile ("movl 8(%1), %0" : "=r" (args[0])  : "r"(ebp));
c0100a0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100a0f:	8b 40 08             	mov    0x8(%eax),%eax
c0100a12:	89 45 d8             	mov    %eax,-0x28(%ebp)
		asm volatile ("movl 12(%1), %0" : "=r" (args[1])  : "r"(ebp));
c0100a15:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100a18:	8b 40 0c             	mov    0xc(%eax),%eax
c0100a1b:	89 45 dc             	mov    %eax,-0x24(%ebp)
		asm volatile ("movl 16(%1), %0" : "=r" (args[2])  : "r"(ebp));
c0100a1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100a21:	8b 40 10             	mov    0x10(%eax),%eax
c0100a24:	89 45 e0             	mov    %eax,-0x20(%ebp)
		asm volatile ("movl 20(%1), %0" : "=r" (args[3])  : "r"(ebp));
c0100a27:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100a2a:	8b 40 14             	mov    0x14(%eax),%eax
c0100a2d:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		cprintf("ebp:0x%08x", ebp);
c0100a30:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100a33:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100a37:	c7 04 24 68 62 10 c0 	movl   $0xc0106268,(%esp)
c0100a3e:	e8 09 f9 ff ff       	call   c010034c <cprintf>
		cprintf(" eip:0x%08x", eip);
c0100a43:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0100a46:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100a4a:	c7 04 24 73 62 10 c0 	movl   $0xc0106273,(%esp)
c0100a51:	e8 f6 f8 ff ff       	call   c010034c <cprintf>
		cprintf(" args:0x%08x 0x%08x 0x%08x 0x%08x", args[0], args[1], args[2], args[3]);
c0100a56:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
c0100a59:	8b 4d e0             	mov    -0x20(%ebp),%ecx
c0100a5c:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0100a5f:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0100a62:	89 5c 24 10          	mov    %ebx,0x10(%esp)
c0100a66:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
c0100a6a:	89 54 24 08          	mov    %edx,0x8(%esp)
c0100a6e:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100a72:	c7 04 24 80 62 10 c0 	movl   $0xc0106280,(%esp)
c0100a79:	e8 ce f8 ff ff       	call   c010034c <cprintf>
		cprintf("\n");
c0100a7e:	c7 04 24 a2 62 10 c0 	movl   $0xc01062a2,(%esp)
c0100a85:	e8 c2 f8 ff ff       	call   c010034c <cprintf>
		print_debuginfo(eip-1);
c0100a8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0100a8d:	83 e8 01             	sub    $0x1,%eax
c0100a90:	89 04 24             	mov    %eax,(%esp)
c0100a93:	e8 7e fe ff ff       	call   c0100916 <print_debuginfo>

		asm volatile ("movl 4(%1), %0" : "=r" (eip) : "r"(ebp));
c0100a98:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100a9b:	8b 40 04             	mov    0x4(%eax),%eax
c0100a9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		asm volatile ("movl 0(%1), %0" : "=r" (ebp) : "r"(ebp));
c0100aa1:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100aa4:	8b 00                	mov    (%eax),%eax
c0100aa6:	89 45 f4             	mov    %eax,-0xc(%ebp)
      */

	uint32_t ebp= read_ebp(), eip= read_eip();

	int i=0;
	while (ebp!=0 && (i++)<STACKFRAME_DEPTH )
c0100aa9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0100aad:	74 12                	je     c0100ac1 <print_stackframe+0xf7>
c0100aaf:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0100ab2:	8d 50 01             	lea    0x1(%eax),%edx
c0100ab5:	89 55 ec             	mov    %edx,-0x14(%ebp)
c0100ab8:	83 f8 13             	cmp    $0x13,%eax
c0100abb:	0f 8e 2f ff ff ff    	jle    c01009f0 <print_stackframe+0x26>
		print_debuginfo(eip-1);

		asm volatile ("movl 4(%1), %0" : "=r" (eip) : "r"(ebp));
		asm volatile ("movl 0(%1), %0" : "=r" (ebp) : "r"(ebp));
	}
}
c0100ac1:	83 c4 44             	add    $0x44,%esp
c0100ac4:	5b                   	pop    %ebx
c0100ac5:	5d                   	pop    %ebp
c0100ac6:	c3                   	ret    

c0100ac7 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
c0100ac7:	55                   	push   %ebp
c0100ac8:	89 e5                	mov    %esp,%ebp
c0100aca:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
c0100acd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
c0100ad4:	eb 0c                	jmp    c0100ae2 <parse+0x1b>
            *buf ++ = '\0';
c0100ad6:	8b 45 08             	mov    0x8(%ebp),%eax
c0100ad9:	8d 50 01             	lea    0x1(%eax),%edx
c0100adc:	89 55 08             	mov    %edx,0x8(%ebp)
c0100adf:	c6 00 00             	movb   $0x0,(%eax)
static int
parse(char *buf, char **argv) {
    int argc = 0;
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
c0100ae2:	8b 45 08             	mov    0x8(%ebp),%eax
c0100ae5:	0f b6 00             	movzbl (%eax),%eax
c0100ae8:	84 c0                	test   %al,%al
c0100aea:	74 1d                	je     c0100b09 <parse+0x42>
c0100aec:	8b 45 08             	mov    0x8(%ebp),%eax
c0100aef:	0f b6 00             	movzbl (%eax),%eax
c0100af2:	0f be c0             	movsbl %al,%eax
c0100af5:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100af9:	c7 04 24 24 63 10 c0 	movl   $0xc0106324,(%esp)
c0100b00:	e8 74 52 00 00       	call   c0105d79 <strchr>
c0100b05:	85 c0                	test   %eax,%eax
c0100b07:	75 cd                	jne    c0100ad6 <parse+0xf>
            *buf ++ = '\0';
        }
        if (*buf == '\0') {
c0100b09:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b0c:	0f b6 00             	movzbl (%eax),%eax
c0100b0f:	84 c0                	test   %al,%al
c0100b11:	75 02                	jne    c0100b15 <parse+0x4e>
            break;
c0100b13:	eb 67                	jmp    c0100b7c <parse+0xb5>
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
c0100b15:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
c0100b19:	75 14                	jne    c0100b2f <parse+0x68>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
c0100b1b:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
c0100b22:	00 
c0100b23:	c7 04 24 29 63 10 c0 	movl   $0xc0106329,(%esp)
c0100b2a:	e8 1d f8 ff ff       	call   c010034c <cprintf>
        }
        argv[argc ++] = buf;
c0100b2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100b32:	8d 50 01             	lea    0x1(%eax),%edx
c0100b35:	89 55 f4             	mov    %edx,-0xc(%ebp)
c0100b38:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0100b3f:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100b42:	01 c2                	add    %eax,%edx
c0100b44:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b47:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
c0100b49:	eb 04                	jmp    c0100b4f <parse+0x88>
            buf ++;
c0100b4b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        // save and scan past next arg
        if (argc == MAXARGS - 1) {
            cprintf("Too many arguments (max %d).\n", MAXARGS);
        }
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
c0100b4f:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b52:	0f b6 00             	movzbl (%eax),%eax
c0100b55:	84 c0                	test   %al,%al
c0100b57:	74 1d                	je     c0100b76 <parse+0xaf>
c0100b59:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b5c:	0f b6 00             	movzbl (%eax),%eax
c0100b5f:	0f be c0             	movsbl %al,%eax
c0100b62:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100b66:	c7 04 24 24 63 10 c0 	movl   $0xc0106324,(%esp)
c0100b6d:	e8 07 52 00 00       	call   c0105d79 <strchr>
c0100b72:	85 c0                	test   %eax,%eax
c0100b74:	74 d5                	je     c0100b4b <parse+0x84>
            buf ++;
        }
    }
c0100b76:	90                   	nop
static int
parse(char *buf, char **argv) {
    int argc = 0;
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
c0100b77:	e9 66 ff ff ff       	jmp    c0100ae2 <parse+0x1b>
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
            buf ++;
        }
    }
    return argc;
c0100b7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0100b7f:	c9                   	leave  
c0100b80:	c3                   	ret    

c0100b81 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
c0100b81:	55                   	push   %ebp
c0100b82:	89 e5                	mov    %esp,%ebp
c0100b84:	83 ec 68             	sub    $0x68,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
c0100b87:	8d 45 b0             	lea    -0x50(%ebp),%eax
c0100b8a:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100b8e:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b91:	89 04 24             	mov    %eax,(%esp)
c0100b94:	e8 2e ff ff ff       	call   c0100ac7 <parse>
c0100b99:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
c0100b9c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0100ba0:	75 0a                	jne    c0100bac <runcmd+0x2b>
        return 0;
c0100ba2:	b8 00 00 00 00       	mov    $0x0,%eax
c0100ba7:	e9 85 00 00 00       	jmp    c0100c31 <runcmd+0xb0>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
c0100bac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0100bb3:	eb 5c                	jmp    c0100c11 <runcmd+0x90>
        if (strcmp(commands[i].name, argv[0]) == 0) {
c0100bb5:	8b 4d b0             	mov    -0x50(%ebp),%ecx
c0100bb8:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100bbb:	89 d0                	mov    %edx,%eax
c0100bbd:	01 c0                	add    %eax,%eax
c0100bbf:	01 d0                	add    %edx,%eax
c0100bc1:	c1 e0 02             	shl    $0x2,%eax
c0100bc4:	05 20 70 11 c0       	add    $0xc0117020,%eax
c0100bc9:	8b 00                	mov    (%eax),%eax
c0100bcb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
c0100bcf:	89 04 24             	mov    %eax,(%esp)
c0100bd2:	e8 03 51 00 00       	call   c0105cda <strcmp>
c0100bd7:	85 c0                	test   %eax,%eax
c0100bd9:	75 32                	jne    c0100c0d <runcmd+0x8c>
            return commands[i].func(argc - 1, argv + 1, tf);
c0100bdb:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100bde:	89 d0                	mov    %edx,%eax
c0100be0:	01 c0                	add    %eax,%eax
c0100be2:	01 d0                	add    %edx,%eax
c0100be4:	c1 e0 02             	shl    $0x2,%eax
c0100be7:	05 20 70 11 c0       	add    $0xc0117020,%eax
c0100bec:	8b 40 08             	mov    0x8(%eax),%eax
c0100bef:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0100bf2:	8d 4a ff             	lea    -0x1(%edx),%ecx
c0100bf5:	8b 55 0c             	mov    0xc(%ebp),%edx
c0100bf8:	89 54 24 08          	mov    %edx,0x8(%esp)
c0100bfc:	8d 55 b0             	lea    -0x50(%ebp),%edx
c0100bff:	83 c2 04             	add    $0x4,%edx
c0100c02:	89 54 24 04          	mov    %edx,0x4(%esp)
c0100c06:	89 0c 24             	mov    %ecx,(%esp)
c0100c09:	ff d0                	call   *%eax
c0100c0b:	eb 24                	jmp    c0100c31 <runcmd+0xb0>
    int argc = parse(buf, argv);
    if (argc == 0) {
        return 0;
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
c0100c0d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0100c11:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100c14:	83 f8 02             	cmp    $0x2,%eax
c0100c17:	76 9c                	jbe    c0100bb5 <runcmd+0x34>
        if (strcmp(commands[i].name, argv[0]) == 0) {
            return commands[i].func(argc - 1, argv + 1, tf);
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
c0100c19:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0100c1c:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100c20:	c7 04 24 47 63 10 c0 	movl   $0xc0106347,(%esp)
c0100c27:	e8 20 f7 ff ff       	call   c010034c <cprintf>
    return 0;
c0100c2c:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100c31:	c9                   	leave  
c0100c32:	c3                   	ret    

c0100c33 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
c0100c33:	55                   	push   %ebp
c0100c34:	89 e5                	mov    %esp,%ebp
c0100c36:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
c0100c39:	c7 04 24 60 63 10 c0 	movl   $0xc0106360,(%esp)
c0100c40:	e8 07 f7 ff ff       	call   c010034c <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
c0100c45:	c7 04 24 88 63 10 c0 	movl   $0xc0106388,(%esp)
c0100c4c:	e8 fb f6 ff ff       	call   c010034c <cprintf>

    if (tf != NULL) {
c0100c51:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0100c55:	74 0b                	je     c0100c62 <kmonitor+0x2f>
        print_trapframe(tf);
c0100c57:	8b 45 08             	mov    0x8(%ebp),%eax
c0100c5a:	89 04 24             	mov    %eax,(%esp)
c0100c5d:	e8 58 0e 00 00       	call   c0101aba <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
c0100c62:	c7 04 24 ad 63 10 c0 	movl   $0xc01063ad,(%esp)
c0100c69:	e8 d5 f5 ff ff       	call   c0100243 <readline>
c0100c6e:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0100c71:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0100c75:	74 18                	je     c0100c8f <kmonitor+0x5c>
            if (runcmd(buf, tf) < 0) {
c0100c77:	8b 45 08             	mov    0x8(%ebp),%eax
c0100c7a:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100c7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100c81:	89 04 24             	mov    %eax,(%esp)
c0100c84:	e8 f8 fe ff ff       	call   c0100b81 <runcmd>
c0100c89:	85 c0                	test   %eax,%eax
c0100c8b:	79 02                	jns    c0100c8f <kmonitor+0x5c>
                break;
c0100c8d:	eb 02                	jmp    c0100c91 <kmonitor+0x5e>
            }
        }
    }
c0100c8f:	eb d1                	jmp    c0100c62 <kmonitor+0x2f>
}
c0100c91:	c9                   	leave  
c0100c92:	c3                   	ret    

c0100c93 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
c0100c93:	55                   	push   %ebp
c0100c94:	89 e5                	mov    %esp,%ebp
c0100c96:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
c0100c99:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0100ca0:	eb 3f                	jmp    c0100ce1 <mon_help+0x4e>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
c0100ca2:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100ca5:	89 d0                	mov    %edx,%eax
c0100ca7:	01 c0                	add    %eax,%eax
c0100ca9:	01 d0                	add    %edx,%eax
c0100cab:	c1 e0 02             	shl    $0x2,%eax
c0100cae:	05 20 70 11 c0       	add    $0xc0117020,%eax
c0100cb3:	8b 48 04             	mov    0x4(%eax),%ecx
c0100cb6:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100cb9:	89 d0                	mov    %edx,%eax
c0100cbb:	01 c0                	add    %eax,%eax
c0100cbd:	01 d0                	add    %edx,%eax
c0100cbf:	c1 e0 02             	shl    $0x2,%eax
c0100cc2:	05 20 70 11 c0       	add    $0xc0117020,%eax
c0100cc7:	8b 00                	mov    (%eax),%eax
c0100cc9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
c0100ccd:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100cd1:	c7 04 24 b1 63 10 c0 	movl   $0xc01063b1,(%esp)
c0100cd8:	e8 6f f6 ff ff       	call   c010034c <cprintf>

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
c0100cdd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0100ce1:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100ce4:	83 f8 02             	cmp    $0x2,%eax
c0100ce7:	76 b9                	jbe    c0100ca2 <mon_help+0xf>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
    }
    return 0;
c0100ce9:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100cee:	c9                   	leave  
c0100cef:	c3                   	ret    

c0100cf0 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
c0100cf0:	55                   	push   %ebp
c0100cf1:	89 e5                	mov    %esp,%ebp
c0100cf3:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
c0100cf6:	e8 85 fb ff ff       	call   c0100880 <print_kerninfo>
    return 0;
c0100cfb:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100d00:	c9                   	leave  
c0100d01:	c3                   	ret    

c0100d02 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
c0100d02:	55                   	push   %ebp
c0100d03:	89 e5                	mov    %esp,%ebp
c0100d05:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
c0100d08:	e8 bd fc ff ff       	call   c01009ca <print_stackframe>
    return 0;
c0100d0d:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100d12:	c9                   	leave  
c0100d13:	c3                   	ret    

c0100d14 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
c0100d14:	55                   	push   %ebp
c0100d15:	89 e5                	mov    %esp,%ebp
c0100d17:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
c0100d1a:	a1 60 7e 11 c0       	mov    0xc0117e60,%eax
c0100d1f:	85 c0                	test   %eax,%eax
c0100d21:	74 02                	je     c0100d25 <__panic+0x11>
        goto panic_dead;
c0100d23:	eb 48                	jmp    c0100d6d <__panic+0x59>
    }
    is_panic = 1;
c0100d25:	c7 05 60 7e 11 c0 01 	movl   $0x1,0xc0117e60
c0100d2c:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
c0100d2f:	8d 45 14             	lea    0x14(%ebp),%eax
c0100d32:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
c0100d35:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100d38:	89 44 24 08          	mov    %eax,0x8(%esp)
c0100d3c:	8b 45 08             	mov    0x8(%ebp),%eax
c0100d3f:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100d43:	c7 04 24 ba 63 10 c0 	movl   $0xc01063ba,(%esp)
c0100d4a:	e8 fd f5 ff ff       	call   c010034c <cprintf>
    vcprintf(fmt, ap);
c0100d4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100d52:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100d56:	8b 45 10             	mov    0x10(%ebp),%eax
c0100d59:	89 04 24             	mov    %eax,(%esp)
c0100d5c:	e8 b8 f5 ff ff       	call   c0100319 <vcprintf>
    cprintf("\n");
c0100d61:	c7 04 24 d6 63 10 c0 	movl   $0xc01063d6,(%esp)
c0100d68:	e8 df f5 ff ff       	call   c010034c <cprintf>
    va_end(ap);

panic_dead:
    intr_disable();
c0100d6d:	e8 85 09 00 00       	call   c01016f7 <intr_disable>
    while (1) {
        kmonitor(NULL);
c0100d72:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
c0100d79:	e8 b5 fe ff ff       	call   c0100c33 <kmonitor>
    }
c0100d7e:	eb f2                	jmp    c0100d72 <__panic+0x5e>

c0100d80 <__warn>:
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
c0100d80:	55                   	push   %ebp
c0100d81:	89 e5                	mov    %esp,%ebp
c0100d83:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
c0100d86:	8d 45 14             	lea    0x14(%ebp),%eax
c0100d89:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
c0100d8c:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100d8f:	89 44 24 08          	mov    %eax,0x8(%esp)
c0100d93:	8b 45 08             	mov    0x8(%ebp),%eax
c0100d96:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100d9a:	c7 04 24 d8 63 10 c0 	movl   $0xc01063d8,(%esp)
c0100da1:	e8 a6 f5 ff ff       	call   c010034c <cprintf>
    vcprintf(fmt, ap);
c0100da6:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100da9:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100dad:	8b 45 10             	mov    0x10(%ebp),%eax
c0100db0:	89 04 24             	mov    %eax,(%esp)
c0100db3:	e8 61 f5 ff ff       	call   c0100319 <vcprintf>
    cprintf("\n");
c0100db8:	c7 04 24 d6 63 10 c0 	movl   $0xc01063d6,(%esp)
c0100dbf:	e8 88 f5 ff ff       	call   c010034c <cprintf>
    va_end(ap);
}
c0100dc4:	c9                   	leave  
c0100dc5:	c3                   	ret    

c0100dc6 <is_kernel_panic>:

bool
is_kernel_panic(void) {
c0100dc6:	55                   	push   %ebp
c0100dc7:	89 e5                	mov    %esp,%ebp
    return is_panic;
c0100dc9:	a1 60 7e 11 c0       	mov    0xc0117e60,%eax
}
c0100dce:	5d                   	pop    %ebp
c0100dcf:	c3                   	ret    

c0100dd0 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
c0100dd0:	55                   	push   %ebp
c0100dd1:	89 e5                	mov    %esp,%ebp
c0100dd3:	83 ec 28             	sub    $0x28,%esp
c0100dd6:	66 c7 45 f6 43 00    	movw   $0x43,-0xa(%ebp)
c0100ddc:	c6 45 f5 34          	movb   $0x34,-0xb(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100de0:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c0100de4:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c0100de8:	ee                   	out    %al,(%dx)
c0100de9:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
c0100def:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
c0100df3:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0100df7:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c0100dfb:	ee                   	out    %al,(%dx)
c0100dfc:	66 c7 45 ee 40 00    	movw   $0x40,-0x12(%ebp)
c0100e02:	c6 45 ed 2e          	movb   $0x2e,-0x13(%ebp)
c0100e06:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0100e0a:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c0100e0e:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
c0100e0f:	c7 05 4c 89 11 c0 00 	movl   $0x0,0xc011894c
c0100e16:	00 00 00 

    cprintf("++ setup timer interrupts\n");
c0100e19:	c7 04 24 f6 63 10 c0 	movl   $0xc01063f6,(%esp)
c0100e20:	e8 27 f5 ff ff       	call   c010034c <cprintf>
    pic_enable(IRQ_TIMER);
c0100e25:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
c0100e2c:	e8 24 09 00 00       	call   c0101755 <pic_enable>
}
c0100e31:	c9                   	leave  
c0100e32:	c3                   	ret    

c0100e33 <__intr_save>:
#include <x86.h>
#include <intr.h>
#include <mmu.h>

static inline bool
__intr_save(void) {
c0100e33:	55                   	push   %ebp
c0100e34:	89 e5                	mov    %esp,%ebp
c0100e36:	83 ec 18             	sub    $0x18,%esp
}

static inline uint32_t
read_eflags(void) {
    uint32_t eflags;
    asm volatile ("pushfl; popl %0" : "=r" (eflags));
c0100e39:	9c                   	pushf  
c0100e3a:	58                   	pop    %eax
c0100e3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return eflags;
c0100e3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    if (read_eflags() & FL_IF) {
c0100e41:	25 00 02 00 00       	and    $0x200,%eax
c0100e46:	85 c0                	test   %eax,%eax
c0100e48:	74 0c                	je     c0100e56 <__intr_save+0x23>
        intr_disable();
c0100e4a:	e8 a8 08 00 00       	call   c01016f7 <intr_disable>
        return 1;
c0100e4f:	b8 01 00 00 00       	mov    $0x1,%eax
c0100e54:	eb 05                	jmp    c0100e5b <__intr_save+0x28>
    }
    return 0;
c0100e56:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100e5b:	c9                   	leave  
c0100e5c:	c3                   	ret    

c0100e5d <__intr_restore>:

static inline void
__intr_restore(bool flag) {
c0100e5d:	55                   	push   %ebp
c0100e5e:	89 e5                	mov    %esp,%ebp
c0100e60:	83 ec 08             	sub    $0x8,%esp
    if (flag) {
c0100e63:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0100e67:	74 05                	je     c0100e6e <__intr_restore+0x11>
        intr_enable();
c0100e69:	e8 83 08 00 00       	call   c01016f1 <intr_enable>
    }
}
c0100e6e:	c9                   	leave  
c0100e6f:	c3                   	ret    

c0100e70 <delay>:
#include <memlayout.h>
#include <sync.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
c0100e70:	55                   	push   %ebp
c0100e71:	89 e5                	mov    %esp,%ebp
c0100e73:	83 ec 10             	sub    $0x10,%esp
c0100e76:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100e7c:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
c0100e80:	89 c2                	mov    %eax,%edx
c0100e82:	ec                   	in     (%dx),%al
c0100e83:	88 45 fd             	mov    %al,-0x3(%ebp)
c0100e86:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
c0100e8c:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c0100e90:	89 c2                	mov    %eax,%edx
c0100e92:	ec                   	in     (%dx),%al
c0100e93:	88 45 f9             	mov    %al,-0x7(%ebp)
c0100e96:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
c0100e9c:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c0100ea0:	89 c2                	mov    %eax,%edx
c0100ea2:	ec                   	in     (%dx),%al
c0100ea3:	88 45 f5             	mov    %al,-0xb(%ebp)
c0100ea6:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
c0100eac:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c0100eb0:	89 c2                	mov    %eax,%edx
c0100eb2:	ec                   	in     (%dx),%al
c0100eb3:	88 45 f1             	mov    %al,-0xf(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
c0100eb6:	c9                   	leave  
c0100eb7:	c3                   	ret    

c0100eb8 <cga_init>:
static uint16_t addr_6845;

/* TEXT-mode CGA/VGA display output */

static void
cga_init(void) {
c0100eb8:	55                   	push   %ebp
c0100eb9:	89 e5                	mov    %esp,%ebp
c0100ebb:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)(CGA_BUF + KERNBASE);
c0100ebe:	c7 45 fc 00 80 0b c0 	movl   $0xc00b8000,-0x4(%ebp)
    uint16_t was = *cp;
c0100ec5:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100ec8:	0f b7 00             	movzwl (%eax),%eax
c0100ecb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;
c0100ecf:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100ed2:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {
c0100ed7:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100eda:	0f b7 00             	movzwl (%eax),%eax
c0100edd:	66 3d 5a a5          	cmp    $0xa55a,%ax
c0100ee1:	74 12                	je     c0100ef5 <cga_init+0x3d>
        cp = (uint16_t*)(MONO_BUF + KERNBASE);
c0100ee3:	c7 45 fc 00 00 0b c0 	movl   $0xc00b0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;
c0100eea:	66 c7 05 86 7e 11 c0 	movw   $0x3b4,0xc0117e86
c0100ef1:	b4 03 
c0100ef3:	eb 13                	jmp    c0100f08 <cga_init+0x50>
    } else {
        *cp = was;
c0100ef5:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100ef8:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
c0100efc:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;
c0100eff:	66 c7 05 86 7e 11 c0 	movw   $0x3d4,0xc0117e86
c0100f06:	d4 03 
    }

    // Extract cursor location
    uint32_t pos;
    outb(addr_6845, 14);
c0100f08:	0f b7 05 86 7e 11 c0 	movzwl 0xc0117e86,%eax
c0100f0f:	0f b7 c0             	movzwl %ax,%eax
c0100f12:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
c0100f16:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100f1a:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0100f1e:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c0100f22:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;
c0100f23:	0f b7 05 86 7e 11 c0 	movzwl 0xc0117e86,%eax
c0100f2a:	83 c0 01             	add    $0x1,%eax
c0100f2d:	0f b7 c0             	movzwl %ax,%eax
c0100f30:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100f34:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
c0100f38:	89 c2                	mov    %eax,%edx
c0100f3a:	ec                   	in     (%dx),%al
c0100f3b:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
c0100f3e:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0100f42:	0f b6 c0             	movzbl %al,%eax
c0100f45:	c1 e0 08             	shl    $0x8,%eax
c0100f48:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
c0100f4b:	0f b7 05 86 7e 11 c0 	movzwl 0xc0117e86,%eax
c0100f52:	0f b7 c0             	movzwl %ax,%eax
c0100f55:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
c0100f59:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100f5d:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c0100f61:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
c0100f65:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);
c0100f66:	0f b7 05 86 7e 11 c0 	movzwl 0xc0117e86,%eax
c0100f6d:	83 c0 01             	add    $0x1,%eax
c0100f70:	0f b7 c0             	movzwl %ax,%eax
c0100f73:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100f77:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
c0100f7b:	89 c2                	mov    %eax,%edx
c0100f7d:	ec                   	in     (%dx),%al
c0100f7e:	88 45 e5             	mov    %al,-0x1b(%ebp)
    return data;
c0100f81:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c0100f85:	0f b6 c0             	movzbl %al,%eax
c0100f88:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;
c0100f8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100f8e:	a3 80 7e 11 c0       	mov    %eax,0xc0117e80
    crt_pos = pos;
c0100f93:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100f96:	66 a3 84 7e 11 c0    	mov    %ax,0xc0117e84
}
c0100f9c:	c9                   	leave  
c0100f9d:	c3                   	ret    

c0100f9e <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
c0100f9e:	55                   	push   %ebp
c0100f9f:	89 e5                	mov    %esp,%ebp
c0100fa1:	83 ec 48             	sub    $0x48,%esp
c0100fa4:	66 c7 45 f6 fa 03    	movw   $0x3fa,-0xa(%ebp)
c0100faa:	c6 45 f5 00          	movb   $0x0,-0xb(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100fae:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c0100fb2:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c0100fb6:	ee                   	out    %al,(%dx)
c0100fb7:	66 c7 45 f2 fb 03    	movw   $0x3fb,-0xe(%ebp)
c0100fbd:	c6 45 f1 80          	movb   $0x80,-0xf(%ebp)
c0100fc1:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0100fc5:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c0100fc9:	ee                   	out    %al,(%dx)
c0100fca:	66 c7 45 ee f8 03    	movw   $0x3f8,-0x12(%ebp)
c0100fd0:	c6 45 ed 0c          	movb   $0xc,-0x13(%ebp)
c0100fd4:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0100fd8:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c0100fdc:	ee                   	out    %al,(%dx)
c0100fdd:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
c0100fe3:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
c0100fe7:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c0100feb:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
c0100fef:	ee                   	out    %al,(%dx)
c0100ff0:	66 c7 45 e6 fb 03    	movw   $0x3fb,-0x1a(%ebp)
c0100ff6:	c6 45 e5 03          	movb   $0x3,-0x1b(%ebp)
c0100ffa:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c0100ffe:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c0101002:	ee                   	out    %al,(%dx)
c0101003:	66 c7 45 e2 fc 03    	movw   $0x3fc,-0x1e(%ebp)
c0101009:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
c010100d:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
c0101011:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
c0101015:	ee                   	out    %al,(%dx)
c0101016:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
c010101c:	c6 45 dd 01          	movb   $0x1,-0x23(%ebp)
c0101020:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
c0101024:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
c0101028:	ee                   	out    %al,(%dx)
c0101029:	66 c7 45 da fd 03    	movw   $0x3fd,-0x26(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c010102f:	0f b7 45 da          	movzwl -0x26(%ebp),%eax
c0101033:	89 c2                	mov    %eax,%edx
c0101035:	ec                   	in     (%dx),%al
c0101036:	88 45 d9             	mov    %al,-0x27(%ebp)
    return data;
c0101039:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
c010103d:	3c ff                	cmp    $0xff,%al
c010103f:	0f 95 c0             	setne  %al
c0101042:	0f b6 c0             	movzbl %al,%eax
c0101045:	a3 88 7e 11 c0       	mov    %eax,0xc0117e88
c010104a:	66 c7 45 d6 fa 03    	movw   $0x3fa,-0x2a(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0101050:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
c0101054:	89 c2                	mov    %eax,%edx
c0101056:	ec                   	in     (%dx),%al
c0101057:	88 45 d5             	mov    %al,-0x2b(%ebp)
c010105a:	66 c7 45 d2 f8 03    	movw   $0x3f8,-0x2e(%ebp)
c0101060:	0f b7 45 d2          	movzwl -0x2e(%ebp),%eax
c0101064:	89 c2                	mov    %eax,%edx
c0101066:	ec                   	in     (%dx),%al
c0101067:	88 45 d1             	mov    %al,-0x2f(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
c010106a:	a1 88 7e 11 c0       	mov    0xc0117e88,%eax
c010106f:	85 c0                	test   %eax,%eax
c0101071:	74 0c                	je     c010107f <serial_init+0xe1>
        pic_enable(IRQ_COM1);
c0101073:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
c010107a:	e8 d6 06 00 00       	call   c0101755 <pic_enable>
    }
}
c010107f:	c9                   	leave  
c0101080:	c3                   	ret    

c0101081 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
c0101081:	55                   	push   %ebp
c0101082:	89 e5                	mov    %esp,%ebp
c0101084:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
c0101087:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c010108e:	eb 09                	jmp    c0101099 <lpt_putc_sub+0x18>
        delay();
c0101090:	e8 db fd ff ff       	call   c0100e70 <delay>
}

static void
lpt_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
c0101095:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c0101099:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
c010109f:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c01010a3:	89 c2                	mov    %eax,%edx
c01010a5:	ec                   	in     (%dx),%al
c01010a6:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
c01010a9:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c01010ad:	84 c0                	test   %al,%al
c01010af:	78 09                	js     c01010ba <lpt_putc_sub+0x39>
c01010b1:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
c01010b8:	7e d6                	jle    c0101090 <lpt_putc_sub+0xf>
        delay();
    }
    outb(LPTPORT + 0, c);
c01010ba:	8b 45 08             	mov    0x8(%ebp),%eax
c01010bd:	0f b6 c0             	movzbl %al,%eax
c01010c0:	66 c7 45 f6 78 03    	movw   $0x378,-0xa(%ebp)
c01010c6:	88 45 f5             	mov    %al,-0xb(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01010c9:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c01010cd:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c01010d1:	ee                   	out    %al,(%dx)
c01010d2:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
c01010d8:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
c01010dc:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c01010e0:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c01010e4:	ee                   	out    %al,(%dx)
c01010e5:	66 c7 45 ee 7a 03    	movw   $0x37a,-0x12(%ebp)
c01010eb:	c6 45 ed 08          	movb   $0x8,-0x13(%ebp)
c01010ef:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c01010f3:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c01010f7:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
c01010f8:	c9                   	leave  
c01010f9:	c3                   	ret    

c01010fa <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
c01010fa:	55                   	push   %ebp
c01010fb:	89 e5                	mov    %esp,%ebp
c01010fd:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
c0101100:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
c0101104:	74 0d                	je     c0101113 <lpt_putc+0x19>
        lpt_putc_sub(c);
c0101106:	8b 45 08             	mov    0x8(%ebp),%eax
c0101109:	89 04 24             	mov    %eax,(%esp)
c010110c:	e8 70 ff ff ff       	call   c0101081 <lpt_putc_sub>
c0101111:	eb 24                	jmp    c0101137 <lpt_putc+0x3d>
    }
    else {
        lpt_putc_sub('\b');
c0101113:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
c010111a:	e8 62 ff ff ff       	call   c0101081 <lpt_putc_sub>
        lpt_putc_sub(' ');
c010111f:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
c0101126:	e8 56 ff ff ff       	call   c0101081 <lpt_putc_sub>
        lpt_putc_sub('\b');
c010112b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
c0101132:	e8 4a ff ff ff       	call   c0101081 <lpt_putc_sub>
    }
}
c0101137:	c9                   	leave  
c0101138:	c3                   	ret    

c0101139 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
c0101139:	55                   	push   %ebp
c010113a:	89 e5                	mov    %esp,%ebp
c010113c:	53                   	push   %ebx
c010113d:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
c0101140:	8b 45 08             	mov    0x8(%ebp),%eax
c0101143:	b0 00                	mov    $0x0,%al
c0101145:	85 c0                	test   %eax,%eax
c0101147:	75 07                	jne    c0101150 <cga_putc+0x17>
        c |= 0x0700;
c0101149:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
c0101150:	8b 45 08             	mov    0x8(%ebp),%eax
c0101153:	0f b6 c0             	movzbl %al,%eax
c0101156:	83 f8 0a             	cmp    $0xa,%eax
c0101159:	74 4c                	je     c01011a7 <cga_putc+0x6e>
c010115b:	83 f8 0d             	cmp    $0xd,%eax
c010115e:	74 57                	je     c01011b7 <cga_putc+0x7e>
c0101160:	83 f8 08             	cmp    $0x8,%eax
c0101163:	0f 85 88 00 00 00    	jne    c01011f1 <cga_putc+0xb8>
    case '\b':
        if (crt_pos > 0) {
c0101169:	0f b7 05 84 7e 11 c0 	movzwl 0xc0117e84,%eax
c0101170:	66 85 c0             	test   %ax,%ax
c0101173:	74 30                	je     c01011a5 <cga_putc+0x6c>
            crt_pos --;
c0101175:	0f b7 05 84 7e 11 c0 	movzwl 0xc0117e84,%eax
c010117c:	83 e8 01             	sub    $0x1,%eax
c010117f:	66 a3 84 7e 11 c0    	mov    %ax,0xc0117e84
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
c0101185:	a1 80 7e 11 c0       	mov    0xc0117e80,%eax
c010118a:	0f b7 15 84 7e 11 c0 	movzwl 0xc0117e84,%edx
c0101191:	0f b7 d2             	movzwl %dx,%edx
c0101194:	01 d2                	add    %edx,%edx
c0101196:	01 c2                	add    %eax,%edx
c0101198:	8b 45 08             	mov    0x8(%ebp),%eax
c010119b:	b0 00                	mov    $0x0,%al
c010119d:	83 c8 20             	or     $0x20,%eax
c01011a0:	66 89 02             	mov    %ax,(%edx)
        }
        break;
c01011a3:	eb 72                	jmp    c0101217 <cga_putc+0xde>
c01011a5:	eb 70                	jmp    c0101217 <cga_putc+0xde>
    case '\n':
        crt_pos += CRT_COLS;
c01011a7:	0f b7 05 84 7e 11 c0 	movzwl 0xc0117e84,%eax
c01011ae:	83 c0 50             	add    $0x50,%eax
c01011b1:	66 a3 84 7e 11 c0    	mov    %ax,0xc0117e84
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
c01011b7:	0f b7 1d 84 7e 11 c0 	movzwl 0xc0117e84,%ebx
c01011be:	0f b7 0d 84 7e 11 c0 	movzwl 0xc0117e84,%ecx
c01011c5:	0f b7 c1             	movzwl %cx,%eax
c01011c8:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
c01011ce:	c1 e8 10             	shr    $0x10,%eax
c01011d1:	89 c2                	mov    %eax,%edx
c01011d3:	66 c1 ea 06          	shr    $0x6,%dx
c01011d7:	89 d0                	mov    %edx,%eax
c01011d9:	c1 e0 02             	shl    $0x2,%eax
c01011dc:	01 d0                	add    %edx,%eax
c01011de:	c1 e0 04             	shl    $0x4,%eax
c01011e1:	29 c1                	sub    %eax,%ecx
c01011e3:	89 ca                	mov    %ecx,%edx
c01011e5:	89 d8                	mov    %ebx,%eax
c01011e7:	29 d0                	sub    %edx,%eax
c01011e9:	66 a3 84 7e 11 c0    	mov    %ax,0xc0117e84
        break;
c01011ef:	eb 26                	jmp    c0101217 <cga_putc+0xde>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
c01011f1:	8b 0d 80 7e 11 c0    	mov    0xc0117e80,%ecx
c01011f7:	0f b7 05 84 7e 11 c0 	movzwl 0xc0117e84,%eax
c01011fe:	8d 50 01             	lea    0x1(%eax),%edx
c0101201:	66 89 15 84 7e 11 c0 	mov    %dx,0xc0117e84
c0101208:	0f b7 c0             	movzwl %ax,%eax
c010120b:	01 c0                	add    %eax,%eax
c010120d:	8d 14 01             	lea    (%ecx,%eax,1),%edx
c0101210:	8b 45 08             	mov    0x8(%ebp),%eax
c0101213:	66 89 02             	mov    %ax,(%edx)
        break;
c0101216:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
c0101217:	0f b7 05 84 7e 11 c0 	movzwl 0xc0117e84,%eax
c010121e:	66 3d cf 07          	cmp    $0x7cf,%ax
c0101222:	76 5b                	jbe    c010127f <cga_putc+0x146>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
c0101224:	a1 80 7e 11 c0       	mov    0xc0117e80,%eax
c0101229:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
c010122f:	a1 80 7e 11 c0       	mov    0xc0117e80,%eax
c0101234:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
c010123b:	00 
c010123c:	89 54 24 04          	mov    %edx,0x4(%esp)
c0101240:	89 04 24             	mov    %eax,(%esp)
c0101243:	e8 2f 4d 00 00       	call   c0105f77 <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
c0101248:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
c010124f:	eb 15                	jmp    c0101266 <cga_putc+0x12d>
            crt_buf[i] = 0x0700 | ' ';
c0101251:	a1 80 7e 11 c0       	mov    0xc0117e80,%eax
c0101256:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0101259:	01 d2                	add    %edx,%edx
c010125b:	01 d0                	add    %edx,%eax
c010125d:	66 c7 00 20 07       	movw   $0x720,(%eax)

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
c0101262:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0101266:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
c010126d:	7e e2                	jle    c0101251 <cga_putc+0x118>
            crt_buf[i] = 0x0700 | ' ';
        }
        crt_pos -= CRT_COLS;
c010126f:	0f b7 05 84 7e 11 c0 	movzwl 0xc0117e84,%eax
c0101276:	83 e8 50             	sub    $0x50,%eax
c0101279:	66 a3 84 7e 11 c0    	mov    %ax,0xc0117e84
    }

    // move that little blinky thing
    outb(addr_6845, 14);
c010127f:	0f b7 05 86 7e 11 c0 	movzwl 0xc0117e86,%eax
c0101286:	0f b7 c0             	movzwl %ax,%eax
c0101289:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
c010128d:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
c0101291:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0101295:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c0101299:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
c010129a:	0f b7 05 84 7e 11 c0 	movzwl 0xc0117e84,%eax
c01012a1:	66 c1 e8 08          	shr    $0x8,%ax
c01012a5:	0f b6 c0             	movzbl %al,%eax
c01012a8:	0f b7 15 86 7e 11 c0 	movzwl 0xc0117e86,%edx
c01012af:	83 c2 01             	add    $0x1,%edx
c01012b2:	0f b7 d2             	movzwl %dx,%edx
c01012b5:	66 89 55 ee          	mov    %dx,-0x12(%ebp)
c01012b9:	88 45 ed             	mov    %al,-0x13(%ebp)
c01012bc:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c01012c0:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c01012c4:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
c01012c5:	0f b7 05 86 7e 11 c0 	movzwl 0xc0117e86,%eax
c01012cc:	0f b7 c0             	movzwl %ax,%eax
c01012cf:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
c01012d3:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
c01012d7:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c01012db:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
c01012df:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
c01012e0:	0f b7 05 84 7e 11 c0 	movzwl 0xc0117e84,%eax
c01012e7:	0f b6 c0             	movzbl %al,%eax
c01012ea:	0f b7 15 86 7e 11 c0 	movzwl 0xc0117e86,%edx
c01012f1:	83 c2 01             	add    $0x1,%edx
c01012f4:	0f b7 d2             	movzwl %dx,%edx
c01012f7:	66 89 55 e6          	mov    %dx,-0x1a(%ebp)
c01012fb:	88 45 e5             	mov    %al,-0x1b(%ebp)
c01012fe:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c0101302:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c0101306:	ee                   	out    %al,(%dx)
}
c0101307:	83 c4 34             	add    $0x34,%esp
c010130a:	5b                   	pop    %ebx
c010130b:	5d                   	pop    %ebp
c010130c:	c3                   	ret    

c010130d <serial_putc_sub>:

static void
serial_putc_sub(int c) {
c010130d:	55                   	push   %ebp
c010130e:	89 e5                	mov    %esp,%ebp
c0101310:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
c0101313:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c010131a:	eb 09                	jmp    c0101325 <serial_putc_sub+0x18>
        delay();
c010131c:	e8 4f fb ff ff       	call   c0100e70 <delay>
}

static void
serial_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
c0101321:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c0101325:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c010132b:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c010132f:	89 c2                	mov    %eax,%edx
c0101331:	ec                   	in     (%dx),%al
c0101332:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
c0101335:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c0101339:	0f b6 c0             	movzbl %al,%eax
c010133c:	83 e0 20             	and    $0x20,%eax
c010133f:	85 c0                	test   %eax,%eax
c0101341:	75 09                	jne    c010134c <serial_putc_sub+0x3f>
c0101343:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
c010134a:	7e d0                	jle    c010131c <serial_putc_sub+0xf>
        delay();
    }
    outb(COM1 + COM_TX, c);
c010134c:	8b 45 08             	mov    0x8(%ebp),%eax
c010134f:	0f b6 c0             	movzbl %al,%eax
c0101352:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
c0101358:	88 45 f5             	mov    %al,-0xb(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010135b:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c010135f:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c0101363:	ee                   	out    %al,(%dx)
}
c0101364:	c9                   	leave  
c0101365:	c3                   	ret    

c0101366 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
c0101366:	55                   	push   %ebp
c0101367:	89 e5                	mov    %esp,%ebp
c0101369:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
c010136c:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
c0101370:	74 0d                	je     c010137f <serial_putc+0x19>
        serial_putc_sub(c);
c0101372:	8b 45 08             	mov    0x8(%ebp),%eax
c0101375:	89 04 24             	mov    %eax,(%esp)
c0101378:	e8 90 ff ff ff       	call   c010130d <serial_putc_sub>
c010137d:	eb 24                	jmp    c01013a3 <serial_putc+0x3d>
    }
    else {
        serial_putc_sub('\b');
c010137f:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
c0101386:	e8 82 ff ff ff       	call   c010130d <serial_putc_sub>
        serial_putc_sub(' ');
c010138b:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
c0101392:	e8 76 ff ff ff       	call   c010130d <serial_putc_sub>
        serial_putc_sub('\b');
c0101397:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
c010139e:	e8 6a ff ff ff       	call   c010130d <serial_putc_sub>
    }
}
c01013a3:	c9                   	leave  
c01013a4:	c3                   	ret    

c01013a5 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
c01013a5:	55                   	push   %ebp
c01013a6:	89 e5                	mov    %esp,%ebp
c01013a8:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
c01013ab:	eb 33                	jmp    c01013e0 <cons_intr+0x3b>
        if (c != 0) {
c01013ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01013b1:	74 2d                	je     c01013e0 <cons_intr+0x3b>
            cons.buf[cons.wpos ++] = c;
c01013b3:	a1 a4 80 11 c0       	mov    0xc01180a4,%eax
c01013b8:	8d 50 01             	lea    0x1(%eax),%edx
c01013bb:	89 15 a4 80 11 c0    	mov    %edx,0xc01180a4
c01013c1:	8b 55 f4             	mov    -0xc(%ebp),%edx
c01013c4:	88 90 a0 7e 11 c0    	mov    %dl,-0x3fee8160(%eax)
            if (cons.wpos == CONSBUFSIZE) {
c01013ca:	a1 a4 80 11 c0       	mov    0xc01180a4,%eax
c01013cf:	3d 00 02 00 00       	cmp    $0x200,%eax
c01013d4:	75 0a                	jne    c01013e0 <cons_intr+0x3b>
                cons.wpos = 0;
c01013d6:	c7 05 a4 80 11 c0 00 	movl   $0x0,0xc01180a4
c01013dd:	00 00 00 
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
    int c;
    while ((c = (*proc)()) != -1) {
c01013e0:	8b 45 08             	mov    0x8(%ebp),%eax
c01013e3:	ff d0                	call   *%eax
c01013e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01013e8:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
c01013ec:	75 bf                	jne    c01013ad <cons_intr+0x8>
            if (cons.wpos == CONSBUFSIZE) {
                cons.wpos = 0;
            }
        }
    }
}
c01013ee:	c9                   	leave  
c01013ef:	c3                   	ret    

c01013f0 <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
c01013f0:	55                   	push   %ebp
c01013f1:	89 e5                	mov    %esp,%ebp
c01013f3:	83 ec 10             	sub    $0x10,%esp
c01013f6:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c01013fc:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c0101400:	89 c2                	mov    %eax,%edx
c0101402:	ec                   	in     (%dx),%al
c0101403:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
c0101406:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
c010140a:	0f b6 c0             	movzbl %al,%eax
c010140d:	83 e0 01             	and    $0x1,%eax
c0101410:	85 c0                	test   %eax,%eax
c0101412:	75 07                	jne    c010141b <serial_proc_data+0x2b>
        return -1;
c0101414:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c0101419:	eb 2a                	jmp    c0101445 <serial_proc_data+0x55>
c010141b:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0101421:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c0101425:	89 c2                	mov    %eax,%edx
c0101427:	ec                   	in     (%dx),%al
c0101428:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
c010142b:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
c010142f:	0f b6 c0             	movzbl %al,%eax
c0101432:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
c0101435:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
c0101439:	75 07                	jne    c0101442 <serial_proc_data+0x52>
        c = '\b';
c010143b:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
c0101442:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c0101445:	c9                   	leave  
c0101446:	c3                   	ret    

c0101447 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
c0101447:	55                   	push   %ebp
c0101448:	89 e5                	mov    %esp,%ebp
c010144a:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
c010144d:	a1 88 7e 11 c0       	mov    0xc0117e88,%eax
c0101452:	85 c0                	test   %eax,%eax
c0101454:	74 0c                	je     c0101462 <serial_intr+0x1b>
        cons_intr(serial_proc_data);
c0101456:	c7 04 24 f0 13 10 c0 	movl   $0xc01013f0,(%esp)
c010145d:	e8 43 ff ff ff       	call   c01013a5 <cons_intr>
    }
}
c0101462:	c9                   	leave  
c0101463:	c3                   	ret    

c0101464 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
c0101464:	55                   	push   %ebp
c0101465:	89 e5                	mov    %esp,%ebp
c0101467:	83 ec 38             	sub    $0x38,%esp
c010146a:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0101470:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
c0101474:	89 c2                	mov    %eax,%edx
c0101476:	ec                   	in     (%dx),%al
c0101477:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
c010147a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
c010147e:	0f b6 c0             	movzbl %al,%eax
c0101481:	83 e0 01             	and    $0x1,%eax
c0101484:	85 c0                	test   %eax,%eax
c0101486:	75 0a                	jne    c0101492 <kbd_proc_data+0x2e>
        return -1;
c0101488:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c010148d:	e9 59 01 00 00       	jmp    c01015eb <kbd_proc_data+0x187>
c0101492:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
static inline void invlpg(void *addr) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0101498:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c010149c:	89 c2                	mov    %eax,%edx
c010149e:	ec                   	in     (%dx),%al
c010149f:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
c01014a2:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
c01014a6:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
c01014a9:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
c01014ad:	75 17                	jne    c01014c6 <kbd_proc_data+0x62>
        // E0 escape character
        shift |= E0ESC;
c01014af:	a1 a8 80 11 c0       	mov    0xc01180a8,%eax
c01014b4:	83 c8 40             	or     $0x40,%eax
c01014b7:	a3 a8 80 11 c0       	mov    %eax,0xc01180a8
        return 0;
c01014bc:	b8 00 00 00 00       	mov    $0x0,%eax
c01014c1:	e9 25 01 00 00       	jmp    c01015eb <kbd_proc_data+0x187>
    } else if (data & 0x80) {
c01014c6:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c01014ca:	84 c0                	test   %al,%al
c01014cc:	79 47                	jns    c0101515 <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
c01014ce:	a1 a8 80 11 c0       	mov    0xc01180a8,%eax
c01014d3:	83 e0 40             	and    $0x40,%eax
c01014d6:	85 c0                	test   %eax,%eax
c01014d8:	75 09                	jne    c01014e3 <kbd_proc_data+0x7f>
c01014da:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c01014de:	83 e0 7f             	and    $0x7f,%eax
c01014e1:	eb 04                	jmp    c01014e7 <kbd_proc_data+0x83>
c01014e3:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c01014e7:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
c01014ea:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c01014ee:	0f b6 80 60 70 11 c0 	movzbl -0x3fee8fa0(%eax),%eax
c01014f5:	83 c8 40             	or     $0x40,%eax
c01014f8:	0f b6 c0             	movzbl %al,%eax
c01014fb:	f7 d0                	not    %eax
c01014fd:	89 c2                	mov    %eax,%edx
c01014ff:	a1 a8 80 11 c0       	mov    0xc01180a8,%eax
c0101504:	21 d0                	and    %edx,%eax
c0101506:	a3 a8 80 11 c0       	mov    %eax,0xc01180a8
        return 0;
c010150b:	b8 00 00 00 00       	mov    $0x0,%eax
c0101510:	e9 d6 00 00 00       	jmp    c01015eb <kbd_proc_data+0x187>
    } else if (shift & E0ESC) {
c0101515:	a1 a8 80 11 c0       	mov    0xc01180a8,%eax
c010151a:	83 e0 40             	and    $0x40,%eax
c010151d:	85 c0                	test   %eax,%eax
c010151f:	74 11                	je     c0101532 <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
c0101521:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
c0101525:	a1 a8 80 11 c0       	mov    0xc01180a8,%eax
c010152a:	83 e0 bf             	and    $0xffffffbf,%eax
c010152d:	a3 a8 80 11 c0       	mov    %eax,0xc01180a8
    }

    shift |= shiftcode[data];
c0101532:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c0101536:	0f b6 80 60 70 11 c0 	movzbl -0x3fee8fa0(%eax),%eax
c010153d:	0f b6 d0             	movzbl %al,%edx
c0101540:	a1 a8 80 11 c0       	mov    0xc01180a8,%eax
c0101545:	09 d0                	or     %edx,%eax
c0101547:	a3 a8 80 11 c0       	mov    %eax,0xc01180a8
    shift ^= togglecode[data];
c010154c:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c0101550:	0f b6 80 60 71 11 c0 	movzbl -0x3fee8ea0(%eax),%eax
c0101557:	0f b6 d0             	movzbl %al,%edx
c010155a:	a1 a8 80 11 c0       	mov    0xc01180a8,%eax
c010155f:	31 d0                	xor    %edx,%eax
c0101561:	a3 a8 80 11 c0       	mov    %eax,0xc01180a8

    c = charcode[shift & (CTL | SHIFT)][data];
c0101566:	a1 a8 80 11 c0       	mov    0xc01180a8,%eax
c010156b:	83 e0 03             	and    $0x3,%eax
c010156e:	8b 14 85 60 75 11 c0 	mov    -0x3fee8aa0(,%eax,4),%edx
c0101575:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c0101579:	01 d0                	add    %edx,%eax
c010157b:	0f b6 00             	movzbl (%eax),%eax
c010157e:	0f b6 c0             	movzbl %al,%eax
c0101581:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
c0101584:	a1 a8 80 11 c0       	mov    0xc01180a8,%eax
c0101589:	83 e0 08             	and    $0x8,%eax
c010158c:	85 c0                	test   %eax,%eax
c010158e:	74 22                	je     c01015b2 <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
c0101590:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
c0101594:	7e 0c                	jle    c01015a2 <kbd_proc_data+0x13e>
c0101596:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
c010159a:	7f 06                	jg     c01015a2 <kbd_proc_data+0x13e>
            c += 'A' - 'a';
c010159c:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
c01015a0:	eb 10                	jmp    c01015b2 <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
c01015a2:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
c01015a6:	7e 0a                	jle    c01015b2 <kbd_proc_data+0x14e>
c01015a8:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
c01015ac:	7f 04                	jg     c01015b2 <kbd_proc_data+0x14e>
            c += 'a' - 'A';
c01015ae:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
c01015b2:	a1 a8 80 11 c0       	mov    0xc01180a8,%eax
c01015b7:	f7 d0                	not    %eax
c01015b9:	83 e0 06             	and    $0x6,%eax
c01015bc:	85 c0                	test   %eax,%eax
c01015be:	75 28                	jne    c01015e8 <kbd_proc_data+0x184>
c01015c0:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
c01015c7:	75 1f                	jne    c01015e8 <kbd_proc_data+0x184>
        cprintf("Rebooting!\n");
c01015c9:	c7 04 24 11 64 10 c0 	movl   $0xc0106411,(%esp)
c01015d0:	e8 77 ed ff ff       	call   c010034c <cprintf>
c01015d5:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
c01015db:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01015df:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
c01015e3:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
c01015e7:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
c01015e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c01015eb:	c9                   	leave  
c01015ec:	c3                   	ret    

c01015ed <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
c01015ed:	55                   	push   %ebp
c01015ee:	89 e5                	mov    %esp,%ebp
c01015f0:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
c01015f3:	c7 04 24 64 14 10 c0 	movl   $0xc0101464,(%esp)
c01015fa:	e8 a6 fd ff ff       	call   c01013a5 <cons_intr>
}
c01015ff:	c9                   	leave  
c0101600:	c3                   	ret    

c0101601 <kbd_init>:

static void
kbd_init(void) {
c0101601:	55                   	push   %ebp
c0101602:	89 e5                	mov    %esp,%ebp
c0101604:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
c0101607:	e8 e1 ff ff ff       	call   c01015ed <kbd_intr>
    pic_enable(IRQ_KBD);
c010160c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0101613:	e8 3d 01 00 00       	call   c0101755 <pic_enable>
}
c0101618:	c9                   	leave  
c0101619:	c3                   	ret    

c010161a <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
c010161a:	55                   	push   %ebp
c010161b:	89 e5                	mov    %esp,%ebp
c010161d:	83 ec 18             	sub    $0x18,%esp
    cga_init();
c0101620:	e8 93 f8 ff ff       	call   c0100eb8 <cga_init>
    serial_init();
c0101625:	e8 74 f9 ff ff       	call   c0100f9e <serial_init>
    kbd_init();
c010162a:	e8 d2 ff ff ff       	call   c0101601 <kbd_init>
    if (!serial_exists) {
c010162f:	a1 88 7e 11 c0       	mov    0xc0117e88,%eax
c0101634:	85 c0                	test   %eax,%eax
c0101636:	75 0c                	jne    c0101644 <cons_init+0x2a>
        cprintf("serial port does not exist!!\n");
c0101638:	c7 04 24 1d 64 10 c0 	movl   $0xc010641d,(%esp)
c010163f:	e8 08 ed ff ff       	call   c010034c <cprintf>
    }
}
c0101644:	c9                   	leave  
c0101645:	c3                   	ret    

c0101646 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
c0101646:	55                   	push   %ebp
c0101647:	89 e5                	mov    %esp,%ebp
c0101649:	83 ec 28             	sub    $0x28,%esp
    bool intr_flag;
    local_intr_save(intr_flag);
c010164c:	e8 e2 f7 ff ff       	call   c0100e33 <__intr_save>
c0101651:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        lpt_putc(c);
c0101654:	8b 45 08             	mov    0x8(%ebp),%eax
c0101657:	89 04 24             	mov    %eax,(%esp)
c010165a:	e8 9b fa ff ff       	call   c01010fa <lpt_putc>
        cga_putc(c);
c010165f:	8b 45 08             	mov    0x8(%ebp),%eax
c0101662:	89 04 24             	mov    %eax,(%esp)
c0101665:	e8 cf fa ff ff       	call   c0101139 <cga_putc>
        serial_putc(c);
c010166a:	8b 45 08             	mov    0x8(%ebp),%eax
c010166d:	89 04 24             	mov    %eax,(%esp)
c0101670:	e8 f1 fc ff ff       	call   c0101366 <serial_putc>
    }
    local_intr_restore(intr_flag);
c0101675:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0101678:	89 04 24             	mov    %eax,(%esp)
c010167b:	e8 dd f7 ff ff       	call   c0100e5d <__intr_restore>
}
c0101680:	c9                   	leave  
c0101681:	c3                   	ret    

c0101682 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
c0101682:	55                   	push   %ebp
c0101683:	89 e5                	mov    %esp,%ebp
c0101685:	83 ec 28             	sub    $0x28,%esp
    int c = 0;
c0101688:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    bool intr_flag;
    local_intr_save(intr_flag);
c010168f:	e8 9f f7 ff ff       	call   c0100e33 <__intr_save>
c0101694:	89 45 f0             	mov    %eax,-0x10(%ebp)
    {
        // poll for any pending input characters,
        // so that this function works even when interrupts are disabled
        // (e.g., when called from the kernel monitor).
        serial_intr();
c0101697:	e8 ab fd ff ff       	call   c0101447 <serial_intr>
        kbd_intr();
c010169c:	e8 4c ff ff ff       	call   c01015ed <kbd_intr>

        // grab the next character from the input buffer.
        if (cons.rpos != cons.wpos) {
c01016a1:	8b 15 a0 80 11 c0    	mov    0xc01180a0,%edx
c01016a7:	a1 a4 80 11 c0       	mov    0xc01180a4,%eax
c01016ac:	39 c2                	cmp    %eax,%edx
c01016ae:	74 31                	je     c01016e1 <cons_getc+0x5f>
            c = cons.buf[cons.rpos ++];
c01016b0:	a1 a0 80 11 c0       	mov    0xc01180a0,%eax
c01016b5:	8d 50 01             	lea    0x1(%eax),%edx
c01016b8:	89 15 a0 80 11 c0    	mov    %edx,0xc01180a0
c01016be:	0f b6 80 a0 7e 11 c0 	movzbl -0x3fee8160(%eax),%eax
c01016c5:	0f b6 c0             	movzbl %al,%eax
c01016c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
            if (cons.rpos == CONSBUFSIZE) {
c01016cb:	a1 a0 80 11 c0       	mov    0xc01180a0,%eax
c01016d0:	3d 00 02 00 00       	cmp    $0x200,%eax
c01016d5:	75 0a                	jne    c01016e1 <cons_getc+0x5f>
                cons.rpos = 0;
c01016d7:	c7 05 a0 80 11 c0 00 	movl   $0x0,0xc01180a0
c01016de:	00 00 00 
            }
        }
    }
    local_intr_restore(intr_flag);
c01016e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01016e4:	89 04 24             	mov    %eax,(%esp)
c01016e7:	e8 71 f7 ff ff       	call   c0100e5d <__intr_restore>
    return c;
c01016ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c01016ef:	c9                   	leave  
c01016f0:	c3                   	ret    

c01016f1 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
c01016f1:	55                   	push   %ebp
c01016f2:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd) : "memory");
}

static inline void
sti(void) {
    asm volatile ("sti");
c01016f4:	fb                   	sti    
    sti();
}
c01016f5:	5d                   	pop    %ebp
c01016f6:	c3                   	ret    

c01016f7 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
c01016f7:	55                   	push   %ebp
c01016f8:	89 e5                	mov    %esp,%ebp
}

static inline void
cli(void) {
    asm volatile ("cli" ::: "memory");
c01016fa:	fa                   	cli    
    cli();
}
c01016fb:	5d                   	pop    %ebp
c01016fc:	c3                   	ret    

c01016fd <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
c01016fd:	55                   	push   %ebp
c01016fe:	89 e5                	mov    %esp,%ebp
c0101700:	83 ec 14             	sub    $0x14,%esp
c0101703:	8b 45 08             	mov    0x8(%ebp),%eax
c0101706:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
c010170a:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c010170e:	66 a3 70 75 11 c0    	mov    %ax,0xc0117570
    if (did_init) {
c0101714:	a1 ac 80 11 c0       	mov    0xc01180ac,%eax
c0101719:	85 c0                	test   %eax,%eax
c010171b:	74 36                	je     c0101753 <pic_setmask+0x56>
        outb(IO_PIC1 + 1, mask);
c010171d:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c0101721:	0f b6 c0             	movzbl %al,%eax
c0101724:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
c010172a:	88 45 fd             	mov    %al,-0x3(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010172d:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
c0101731:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
c0101735:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
c0101736:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c010173a:	66 c1 e8 08          	shr    $0x8,%ax
c010173e:	0f b6 c0             	movzbl %al,%eax
c0101741:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
c0101747:	88 45 f9             	mov    %al,-0x7(%ebp)
c010174a:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c010174e:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
c0101752:	ee                   	out    %al,(%dx)
    }
}
c0101753:	c9                   	leave  
c0101754:	c3                   	ret    

c0101755 <pic_enable>:

void
pic_enable(unsigned int irq) {
c0101755:	55                   	push   %ebp
c0101756:	89 e5                	mov    %esp,%ebp
c0101758:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
c010175b:	8b 45 08             	mov    0x8(%ebp),%eax
c010175e:	ba 01 00 00 00       	mov    $0x1,%edx
c0101763:	89 c1                	mov    %eax,%ecx
c0101765:	d3 e2                	shl    %cl,%edx
c0101767:	89 d0                	mov    %edx,%eax
c0101769:	f7 d0                	not    %eax
c010176b:	89 c2                	mov    %eax,%edx
c010176d:	0f b7 05 70 75 11 c0 	movzwl 0xc0117570,%eax
c0101774:	21 d0                	and    %edx,%eax
c0101776:	0f b7 c0             	movzwl %ax,%eax
c0101779:	89 04 24             	mov    %eax,(%esp)
c010177c:	e8 7c ff ff ff       	call   c01016fd <pic_setmask>
}
c0101781:	c9                   	leave  
c0101782:	c3                   	ret    

c0101783 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
c0101783:	55                   	push   %ebp
c0101784:	89 e5                	mov    %esp,%ebp
c0101786:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
c0101789:	c7 05 ac 80 11 c0 01 	movl   $0x1,0xc01180ac
c0101790:	00 00 00 
c0101793:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
c0101799:	c6 45 fd ff          	movb   $0xff,-0x3(%ebp)
c010179d:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
c01017a1:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
c01017a5:	ee                   	out    %al,(%dx)
c01017a6:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
c01017ac:	c6 45 f9 ff          	movb   $0xff,-0x7(%ebp)
c01017b0:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c01017b4:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
c01017b8:	ee                   	out    %al,(%dx)
c01017b9:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
c01017bf:	c6 45 f5 11          	movb   $0x11,-0xb(%ebp)
c01017c3:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c01017c7:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c01017cb:	ee                   	out    %al,(%dx)
c01017cc:	66 c7 45 f2 21 00    	movw   $0x21,-0xe(%ebp)
c01017d2:	c6 45 f1 20          	movb   $0x20,-0xf(%ebp)
c01017d6:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c01017da:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c01017de:	ee                   	out    %al,(%dx)
c01017df:	66 c7 45 ee 21 00    	movw   $0x21,-0x12(%ebp)
c01017e5:	c6 45 ed 04          	movb   $0x4,-0x13(%ebp)
c01017e9:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c01017ed:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c01017f1:	ee                   	out    %al,(%dx)
c01017f2:	66 c7 45 ea 21 00    	movw   $0x21,-0x16(%ebp)
c01017f8:	c6 45 e9 03          	movb   $0x3,-0x17(%ebp)
c01017fc:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c0101800:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
c0101804:	ee                   	out    %al,(%dx)
c0101805:	66 c7 45 e6 a0 00    	movw   $0xa0,-0x1a(%ebp)
c010180b:	c6 45 e5 11          	movb   $0x11,-0x1b(%ebp)
c010180f:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c0101813:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c0101817:	ee                   	out    %al,(%dx)
c0101818:	66 c7 45 e2 a1 00    	movw   $0xa1,-0x1e(%ebp)
c010181e:	c6 45 e1 28          	movb   $0x28,-0x1f(%ebp)
c0101822:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
c0101826:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
c010182a:	ee                   	out    %al,(%dx)
c010182b:	66 c7 45 de a1 00    	movw   $0xa1,-0x22(%ebp)
c0101831:	c6 45 dd 02          	movb   $0x2,-0x23(%ebp)
c0101835:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
c0101839:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
c010183d:	ee                   	out    %al,(%dx)
c010183e:	66 c7 45 da a1 00    	movw   $0xa1,-0x26(%ebp)
c0101844:	c6 45 d9 03          	movb   $0x3,-0x27(%ebp)
c0101848:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
c010184c:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
c0101850:	ee                   	out    %al,(%dx)
c0101851:	66 c7 45 d6 20 00    	movw   $0x20,-0x2a(%ebp)
c0101857:	c6 45 d5 68          	movb   $0x68,-0x2b(%ebp)
c010185b:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
c010185f:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
c0101863:	ee                   	out    %al,(%dx)
c0101864:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
c010186a:	c6 45 d1 0a          	movb   $0xa,-0x2f(%ebp)
c010186e:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
c0101872:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
c0101876:	ee                   	out    %al,(%dx)
c0101877:	66 c7 45 ce a0 00    	movw   $0xa0,-0x32(%ebp)
c010187d:	c6 45 cd 68          	movb   $0x68,-0x33(%ebp)
c0101881:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
c0101885:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
c0101889:	ee                   	out    %al,(%dx)
c010188a:	66 c7 45 ca a0 00    	movw   $0xa0,-0x36(%ebp)
c0101890:	c6 45 c9 0a          	movb   $0xa,-0x37(%ebp)
c0101894:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
c0101898:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
c010189c:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
c010189d:	0f b7 05 70 75 11 c0 	movzwl 0xc0117570,%eax
c01018a4:	66 83 f8 ff          	cmp    $0xffff,%ax
c01018a8:	74 12                	je     c01018bc <pic_init+0x139>
        pic_setmask(irq_mask);
c01018aa:	0f b7 05 70 75 11 c0 	movzwl 0xc0117570,%eax
c01018b1:	0f b7 c0             	movzwl %ax,%eax
c01018b4:	89 04 24             	mov    %eax,(%esp)
c01018b7:	e8 41 fe ff ff       	call   c01016fd <pic_setmask>
    }
}
c01018bc:	c9                   	leave  
c01018bd:	c3                   	ret    

c01018be <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
c01018be:	55                   	push   %ebp
c01018bf:	89 e5                	mov    %esp,%ebp
c01018c1:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
c01018c4:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
c01018cb:	00 
c01018cc:	c7 04 24 40 64 10 c0 	movl   $0xc0106440,(%esp)
c01018d3:	e8 74 ea ff ff       	call   c010034c <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
c01018d8:	c7 04 24 4a 64 10 c0 	movl   $0xc010644a,(%esp)
c01018df:	e8 68 ea ff ff       	call   c010034c <cprintf>
    panic("EOT: kernel seems ok.");
c01018e4:	c7 44 24 08 58 64 10 	movl   $0xc0106458,0x8(%esp)
c01018eb:	c0 
c01018ec:	c7 44 24 04 12 00 00 	movl   $0x12,0x4(%esp)
c01018f3:	00 
c01018f4:	c7 04 24 6e 64 10 c0 	movl   $0xc010646e,(%esp)
c01018fb:	e8 14 f4 ff ff       	call   c0100d14 <__panic>

c0101900 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
c0101900:	55                   	push   %ebp
c0101901:	89 e5                	mov    %esp,%ebp
c0101903:	83 ec 10             	sub    $0x10,%esp
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
	extern uintptr_t __vectors[];

	int i=0, num=sizeof(idt)/sizeof(idt[0]);
c0101906:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c010190d:	c7 45 f8 00 01 00 00 	movl   $0x100,-0x8(%ebp)
	for (; i<num; ++i)
c0101914:	e9 c3 00 00 00       	jmp    c01019dc <idt_init+0xdc>
		SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
c0101919:	8b 45 fc             	mov    -0x4(%ebp),%eax
c010191c:	8b 04 85 00 76 11 c0 	mov    -0x3fee8a00(,%eax,4),%eax
c0101923:	89 c2                	mov    %eax,%edx
c0101925:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101928:	66 89 14 c5 c0 80 11 	mov    %dx,-0x3fee7f40(,%eax,8)
c010192f:	c0 
c0101930:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101933:	66 c7 04 c5 c2 80 11 	movw   $0x8,-0x3fee7f3e(,%eax,8)
c010193a:	c0 08 00 
c010193d:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101940:	0f b6 14 c5 c4 80 11 	movzbl -0x3fee7f3c(,%eax,8),%edx
c0101947:	c0 
c0101948:	83 e2 e0             	and    $0xffffffe0,%edx
c010194b:	88 14 c5 c4 80 11 c0 	mov    %dl,-0x3fee7f3c(,%eax,8)
c0101952:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101955:	0f b6 14 c5 c4 80 11 	movzbl -0x3fee7f3c(,%eax,8),%edx
c010195c:	c0 
c010195d:	83 e2 1f             	and    $0x1f,%edx
c0101960:	88 14 c5 c4 80 11 c0 	mov    %dl,-0x3fee7f3c(,%eax,8)
c0101967:	8b 45 fc             	mov    -0x4(%ebp),%eax
c010196a:	0f b6 14 c5 c5 80 11 	movzbl -0x3fee7f3b(,%eax,8),%edx
c0101971:	c0 
c0101972:	83 e2 f0             	and    $0xfffffff0,%edx
c0101975:	83 ca 0e             	or     $0xe,%edx
c0101978:	88 14 c5 c5 80 11 c0 	mov    %dl,-0x3fee7f3b(,%eax,8)
c010197f:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101982:	0f b6 14 c5 c5 80 11 	movzbl -0x3fee7f3b(,%eax,8),%edx
c0101989:	c0 
c010198a:	83 e2 ef             	and    $0xffffffef,%edx
c010198d:	88 14 c5 c5 80 11 c0 	mov    %dl,-0x3fee7f3b(,%eax,8)
c0101994:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101997:	0f b6 14 c5 c5 80 11 	movzbl -0x3fee7f3b(,%eax,8),%edx
c010199e:	c0 
c010199f:	83 e2 9f             	and    $0xffffff9f,%edx
c01019a2:	88 14 c5 c5 80 11 c0 	mov    %dl,-0x3fee7f3b(,%eax,8)
c01019a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01019ac:	0f b6 14 c5 c5 80 11 	movzbl -0x3fee7f3b(,%eax,8),%edx
c01019b3:	c0 
c01019b4:	83 ca 80             	or     $0xffffff80,%edx
c01019b7:	88 14 c5 c5 80 11 c0 	mov    %dl,-0x3fee7f3b(,%eax,8)
c01019be:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01019c1:	8b 04 85 00 76 11 c0 	mov    -0x3fee8a00(,%eax,4),%eax
c01019c8:	c1 e8 10             	shr    $0x10,%eax
c01019cb:	89 c2                	mov    %eax,%edx
c01019cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01019d0:	66 89 14 c5 c6 80 11 	mov    %dx,-0x3fee7f3a(,%eax,8)
c01019d7:	c0 
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
	extern uintptr_t __vectors[];

	int i=0, num=sizeof(idt)/sizeof(idt[0]);
	for (; i<num; ++i)
c01019d8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c01019dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01019df:	3b 45 f8             	cmp    -0x8(%ebp),%eax
c01019e2:	0f 8c 31 ff ff ff    	jl     c0101919 <idt_init+0x19>
		SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);

	SETGATE(idt[T_SWITCH_TOK], 1, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
c01019e8:	a1 e4 77 11 c0       	mov    0xc01177e4,%eax
c01019ed:	66 a3 88 84 11 c0    	mov    %ax,0xc0118488
c01019f3:	66 c7 05 8a 84 11 c0 	movw   $0x8,0xc011848a
c01019fa:	08 00 
c01019fc:	0f b6 05 8c 84 11 c0 	movzbl 0xc011848c,%eax
c0101a03:	83 e0 e0             	and    $0xffffffe0,%eax
c0101a06:	a2 8c 84 11 c0       	mov    %al,0xc011848c
c0101a0b:	0f b6 05 8c 84 11 c0 	movzbl 0xc011848c,%eax
c0101a12:	83 e0 1f             	and    $0x1f,%eax
c0101a15:	a2 8c 84 11 c0       	mov    %al,0xc011848c
c0101a1a:	0f b6 05 8d 84 11 c0 	movzbl 0xc011848d,%eax
c0101a21:	83 c8 0f             	or     $0xf,%eax
c0101a24:	a2 8d 84 11 c0       	mov    %al,0xc011848d
c0101a29:	0f b6 05 8d 84 11 c0 	movzbl 0xc011848d,%eax
c0101a30:	83 e0 ef             	and    $0xffffffef,%eax
c0101a33:	a2 8d 84 11 c0       	mov    %al,0xc011848d
c0101a38:	0f b6 05 8d 84 11 c0 	movzbl 0xc011848d,%eax
c0101a3f:	83 c8 60             	or     $0x60,%eax
c0101a42:	a2 8d 84 11 c0       	mov    %al,0xc011848d
c0101a47:	0f b6 05 8d 84 11 c0 	movzbl 0xc011848d,%eax
c0101a4e:	83 c8 80             	or     $0xffffff80,%eax
c0101a51:	a2 8d 84 11 c0       	mov    %al,0xc011848d
c0101a56:	a1 e4 77 11 c0       	mov    0xc01177e4,%eax
c0101a5b:	c1 e8 10             	shr    $0x10,%eax
c0101a5e:	66 a3 8e 84 11 c0    	mov    %ax,0xc011848e
c0101a64:	c7 45 f4 80 75 11 c0 	movl   $0xc0117580,-0xc(%ebp)
    }
}

static inline void
lidt(struct pseudodesc *pd) {
    asm volatile ("lidt (%0)" :: "r" (pd) : "memory");
c0101a6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0101a6e:	0f 01 18             	lidtl  (%eax)

	lidt(&idt_pd);
}
c0101a71:	c9                   	leave  
c0101a72:	c3                   	ret    

c0101a73 <trapname>:

static const char *
trapname(int trapno) {
c0101a73:	55                   	push   %ebp
c0101a74:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
c0101a76:	8b 45 08             	mov    0x8(%ebp),%eax
c0101a79:	83 f8 13             	cmp    $0x13,%eax
c0101a7c:	77 0c                	ja     c0101a8a <trapname+0x17>
        return excnames[trapno];
c0101a7e:	8b 45 08             	mov    0x8(%ebp),%eax
c0101a81:	8b 04 85 c0 67 10 c0 	mov    -0x3fef9840(,%eax,4),%eax
c0101a88:	eb 18                	jmp    c0101aa2 <trapname+0x2f>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
c0101a8a:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
c0101a8e:	7e 0d                	jle    c0101a9d <trapname+0x2a>
c0101a90:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
c0101a94:	7f 07                	jg     c0101a9d <trapname+0x2a>
        return "Hardware Interrupt";
c0101a96:	b8 7f 64 10 c0       	mov    $0xc010647f,%eax
c0101a9b:	eb 05                	jmp    c0101aa2 <trapname+0x2f>
    }
    return "(unknown trap)";
c0101a9d:	b8 92 64 10 c0       	mov    $0xc0106492,%eax
}
c0101aa2:	5d                   	pop    %ebp
c0101aa3:	c3                   	ret    

c0101aa4 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
c0101aa4:	55                   	push   %ebp
c0101aa5:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
c0101aa7:	8b 45 08             	mov    0x8(%ebp),%eax
c0101aaa:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101aae:	66 83 f8 08          	cmp    $0x8,%ax
c0101ab2:	0f 94 c0             	sete   %al
c0101ab5:	0f b6 c0             	movzbl %al,%eax
}
c0101ab8:	5d                   	pop    %ebp
c0101ab9:	c3                   	ret    

c0101aba <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
c0101aba:	55                   	push   %ebp
c0101abb:	89 e5                	mov    %esp,%ebp
c0101abd:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
c0101ac0:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ac3:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101ac7:	c7 04 24 d3 64 10 c0 	movl   $0xc01064d3,(%esp)
c0101ace:	e8 79 e8 ff ff       	call   c010034c <cprintf>
    print_regs(&tf->tf_regs);
c0101ad3:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ad6:	89 04 24             	mov    %eax,(%esp)
c0101ad9:	e8 a1 01 00 00       	call   c0101c7f <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
c0101ade:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ae1:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
c0101ae5:	0f b7 c0             	movzwl %ax,%eax
c0101ae8:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101aec:	c7 04 24 e4 64 10 c0 	movl   $0xc01064e4,(%esp)
c0101af3:	e8 54 e8 ff ff       	call   c010034c <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
c0101af8:	8b 45 08             	mov    0x8(%ebp),%eax
c0101afb:	0f b7 40 28          	movzwl 0x28(%eax),%eax
c0101aff:	0f b7 c0             	movzwl %ax,%eax
c0101b02:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101b06:	c7 04 24 f7 64 10 c0 	movl   $0xc01064f7,(%esp)
c0101b0d:	e8 3a e8 ff ff       	call   c010034c <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
c0101b12:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b15:	0f b7 40 24          	movzwl 0x24(%eax),%eax
c0101b19:	0f b7 c0             	movzwl %ax,%eax
c0101b1c:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101b20:	c7 04 24 0a 65 10 c0 	movl   $0xc010650a,(%esp)
c0101b27:	e8 20 e8 ff ff       	call   c010034c <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
c0101b2c:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b2f:	0f b7 40 20          	movzwl 0x20(%eax),%eax
c0101b33:	0f b7 c0             	movzwl %ax,%eax
c0101b36:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101b3a:	c7 04 24 1d 65 10 c0 	movl   $0xc010651d,(%esp)
c0101b41:	e8 06 e8 ff ff       	call   c010034c <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
c0101b46:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b49:	8b 40 30             	mov    0x30(%eax),%eax
c0101b4c:	89 04 24             	mov    %eax,(%esp)
c0101b4f:	e8 1f ff ff ff       	call   c0101a73 <trapname>
c0101b54:	8b 55 08             	mov    0x8(%ebp),%edx
c0101b57:	8b 52 30             	mov    0x30(%edx),%edx
c0101b5a:	89 44 24 08          	mov    %eax,0x8(%esp)
c0101b5e:	89 54 24 04          	mov    %edx,0x4(%esp)
c0101b62:	c7 04 24 30 65 10 c0 	movl   $0xc0106530,(%esp)
c0101b69:	e8 de e7 ff ff       	call   c010034c <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
c0101b6e:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b71:	8b 40 34             	mov    0x34(%eax),%eax
c0101b74:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101b78:	c7 04 24 42 65 10 c0 	movl   $0xc0106542,(%esp)
c0101b7f:	e8 c8 e7 ff ff       	call   c010034c <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
c0101b84:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b87:	8b 40 38             	mov    0x38(%eax),%eax
c0101b8a:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101b8e:	c7 04 24 51 65 10 c0 	movl   $0xc0106551,(%esp)
c0101b95:	e8 b2 e7 ff ff       	call   c010034c <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
c0101b9a:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b9d:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101ba1:	0f b7 c0             	movzwl %ax,%eax
c0101ba4:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101ba8:	c7 04 24 60 65 10 c0 	movl   $0xc0106560,(%esp)
c0101baf:	e8 98 e7 ff ff       	call   c010034c <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
c0101bb4:	8b 45 08             	mov    0x8(%ebp),%eax
c0101bb7:	8b 40 40             	mov    0x40(%eax),%eax
c0101bba:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101bbe:	c7 04 24 73 65 10 c0 	movl   $0xc0106573,(%esp)
c0101bc5:	e8 82 e7 ff ff       	call   c010034c <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
c0101bca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0101bd1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
c0101bd8:	eb 3e                	jmp    c0101c18 <print_trapframe+0x15e>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
c0101bda:	8b 45 08             	mov    0x8(%ebp),%eax
c0101bdd:	8b 50 40             	mov    0x40(%eax),%edx
c0101be0:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0101be3:	21 d0                	and    %edx,%eax
c0101be5:	85 c0                	test   %eax,%eax
c0101be7:	74 28                	je     c0101c11 <print_trapframe+0x157>
c0101be9:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0101bec:	8b 04 85 a0 75 11 c0 	mov    -0x3fee8a60(,%eax,4),%eax
c0101bf3:	85 c0                	test   %eax,%eax
c0101bf5:	74 1a                	je     c0101c11 <print_trapframe+0x157>
            cprintf("%s,", IA32flags[i]);
c0101bf7:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0101bfa:	8b 04 85 a0 75 11 c0 	mov    -0x3fee8a60(,%eax,4),%eax
c0101c01:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101c05:	c7 04 24 82 65 10 c0 	movl   $0xc0106582,(%esp)
c0101c0c:	e8 3b e7 ff ff       	call   c010034c <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
    cprintf("  flag 0x%08x ", tf->tf_eflags);

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
c0101c11:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0101c15:	d1 65 f0             	shll   -0x10(%ebp)
c0101c18:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0101c1b:	83 f8 17             	cmp    $0x17,%eax
c0101c1e:	76 ba                	jbe    c0101bda <print_trapframe+0x120>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
            cprintf("%s,", IA32flags[i]);
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
c0101c20:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c23:	8b 40 40             	mov    0x40(%eax),%eax
c0101c26:	25 00 30 00 00       	and    $0x3000,%eax
c0101c2b:	c1 e8 0c             	shr    $0xc,%eax
c0101c2e:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101c32:	c7 04 24 86 65 10 c0 	movl   $0xc0106586,(%esp)
c0101c39:	e8 0e e7 ff ff       	call   c010034c <cprintf>

    if (!trap_in_kernel(tf)) {
c0101c3e:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c41:	89 04 24             	mov    %eax,(%esp)
c0101c44:	e8 5b fe ff ff       	call   c0101aa4 <trap_in_kernel>
c0101c49:	85 c0                	test   %eax,%eax
c0101c4b:	75 30                	jne    c0101c7d <print_trapframe+0x1c3>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
c0101c4d:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c50:	8b 40 44             	mov    0x44(%eax),%eax
c0101c53:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101c57:	c7 04 24 8f 65 10 c0 	movl   $0xc010658f,(%esp)
c0101c5e:	e8 e9 e6 ff ff       	call   c010034c <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
c0101c63:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c66:	0f b7 40 48          	movzwl 0x48(%eax),%eax
c0101c6a:	0f b7 c0             	movzwl %ax,%eax
c0101c6d:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101c71:	c7 04 24 9e 65 10 c0 	movl   $0xc010659e,(%esp)
c0101c78:	e8 cf e6 ff ff       	call   c010034c <cprintf>
    }
}
c0101c7d:	c9                   	leave  
c0101c7e:	c3                   	ret    

c0101c7f <print_regs>:

void
print_regs(struct pushregs *regs) {
c0101c7f:	55                   	push   %ebp
c0101c80:	89 e5                	mov    %esp,%ebp
c0101c82:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
c0101c85:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c88:	8b 00                	mov    (%eax),%eax
c0101c8a:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101c8e:	c7 04 24 b1 65 10 c0 	movl   $0xc01065b1,(%esp)
c0101c95:	e8 b2 e6 ff ff       	call   c010034c <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
c0101c9a:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c9d:	8b 40 04             	mov    0x4(%eax),%eax
c0101ca0:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101ca4:	c7 04 24 c0 65 10 c0 	movl   $0xc01065c0,(%esp)
c0101cab:	e8 9c e6 ff ff       	call   c010034c <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
c0101cb0:	8b 45 08             	mov    0x8(%ebp),%eax
c0101cb3:	8b 40 08             	mov    0x8(%eax),%eax
c0101cb6:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101cba:	c7 04 24 cf 65 10 c0 	movl   $0xc01065cf,(%esp)
c0101cc1:	e8 86 e6 ff ff       	call   c010034c <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
c0101cc6:	8b 45 08             	mov    0x8(%ebp),%eax
c0101cc9:	8b 40 0c             	mov    0xc(%eax),%eax
c0101ccc:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101cd0:	c7 04 24 de 65 10 c0 	movl   $0xc01065de,(%esp)
c0101cd7:	e8 70 e6 ff ff       	call   c010034c <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
c0101cdc:	8b 45 08             	mov    0x8(%ebp),%eax
c0101cdf:	8b 40 10             	mov    0x10(%eax),%eax
c0101ce2:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101ce6:	c7 04 24 ed 65 10 c0 	movl   $0xc01065ed,(%esp)
c0101ced:	e8 5a e6 ff ff       	call   c010034c <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
c0101cf2:	8b 45 08             	mov    0x8(%ebp),%eax
c0101cf5:	8b 40 14             	mov    0x14(%eax),%eax
c0101cf8:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101cfc:	c7 04 24 fc 65 10 c0 	movl   $0xc01065fc,(%esp)
c0101d03:	e8 44 e6 ff ff       	call   c010034c <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
c0101d08:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d0b:	8b 40 18             	mov    0x18(%eax),%eax
c0101d0e:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101d12:	c7 04 24 0b 66 10 c0 	movl   $0xc010660b,(%esp)
c0101d19:	e8 2e e6 ff ff       	call   c010034c <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
c0101d1e:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d21:	8b 40 1c             	mov    0x1c(%eax),%eax
c0101d24:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101d28:	c7 04 24 1a 66 10 c0 	movl   $0xc010661a,(%esp)
c0101d2f:	e8 18 e6 ff ff       	call   c010034c <cprintf>
}
c0101d34:	c9                   	leave  
c0101d35:	c3                   	ret    

c0101d36 <trap_dispatch>:

struct trapframe switchk2u, *switchu2k;

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
c0101d36:	55                   	push   %ebp
c0101d37:	89 e5                	mov    %esp,%ebp
c0101d39:	57                   	push   %edi
c0101d3a:	56                   	push   %esi
c0101d3b:	53                   	push   %ebx
c0101d3c:	83 ec 2c             	sub    $0x2c,%esp
    char c;

    switch (tf->tf_trapno) {
c0101d3f:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d42:	8b 40 30             	mov    0x30(%eax),%eax
c0101d45:	83 f8 2f             	cmp    $0x2f,%eax
c0101d48:	77 1d                	ja     c0101d67 <trap_dispatch+0x31>
c0101d4a:	83 f8 2e             	cmp    $0x2e,%eax
c0101d4d:	0f 83 d0 01 00 00    	jae    c0101f23 <trap_dispatch+0x1ed>
c0101d53:	83 f8 21             	cmp    $0x21,%eax
c0101d56:	74 7f                	je     c0101dd7 <trap_dispatch+0xa1>
c0101d58:	83 f8 24             	cmp    $0x24,%eax
c0101d5b:	74 51                	je     c0101dae <trap_dispatch+0x78>
c0101d5d:	83 f8 20             	cmp    $0x20,%eax
c0101d60:	74 1c                	je     c0101d7e <trap_dispatch+0x48>
c0101d62:	e9 84 01 00 00       	jmp    c0101eeb <trap_dispatch+0x1b5>
c0101d67:	83 f8 78             	cmp    $0x78,%eax
c0101d6a:	0f 84 90 00 00 00    	je     c0101e00 <trap_dispatch+0xca>
c0101d70:	83 f8 79             	cmp    $0x79,%eax
c0101d73:	0f 84 fe 00 00 00    	je     c0101e77 <trap_dispatch+0x141>
c0101d79:	e9 6d 01 00 00       	jmp    c0101eeb <trap_dispatch+0x1b5>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
    	ticks++;
c0101d7e:	a1 4c 89 11 c0       	mov    0xc011894c,%eax
c0101d83:	83 c0 01             	add    $0x1,%eax
c0101d86:	a3 4c 89 11 c0       	mov    %eax,0xc011894c
    	if (ticks == TICK_NUM)
c0101d8b:	a1 4c 89 11 c0       	mov    0xc011894c,%eax
c0101d90:	83 f8 64             	cmp    $0x64,%eax
c0101d93:	75 14                	jne    c0101da9 <trap_dispatch+0x73>
    	{
    		print_ticks();
c0101d95:	e8 24 fb ff ff       	call   c01018be <print_ticks>
    		ticks= 0;
c0101d9a:	c7 05 4c 89 11 c0 00 	movl   $0x0,0xc011894c
c0101da1:	00 00 00 
    	}
        break;
c0101da4:	e9 7b 01 00 00       	jmp    c0101f24 <trap_dispatch+0x1ee>
c0101da9:	e9 76 01 00 00       	jmp    c0101f24 <trap_dispatch+0x1ee>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
c0101dae:	e8 cf f8 ff ff       	call   c0101682 <cons_getc>
c0101db3:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
c0101db6:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
c0101dba:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
c0101dbe:	89 54 24 08          	mov    %edx,0x8(%esp)
c0101dc2:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101dc6:	c7 04 24 29 66 10 c0 	movl   $0xc0106629,(%esp)
c0101dcd:	e8 7a e5 ff ff       	call   c010034c <cprintf>
        break;
c0101dd2:	e9 4d 01 00 00       	jmp    c0101f24 <trap_dispatch+0x1ee>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
c0101dd7:	e8 a6 f8 ff ff       	call   c0101682 <cons_getc>
c0101ddc:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
c0101ddf:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
c0101de3:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
c0101de7:	89 54 24 08          	mov    %edx,0x8(%esp)
c0101deb:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101def:	c7 04 24 3b 66 10 c0 	movl   $0xc010663b,(%esp)
c0101df6:	e8 51 e5 ff ff       	call   c010034c <cprintf>
        break;
c0101dfb:	e9 24 01 00 00       	jmp    c0101f24 <trap_dispatch+0x1ee>
    //LAB1 CHALLENGE 1 : 2012011274 you should modify below codes.
    case T_SWITCH_TOU:
    	if (tf->tf_cs != USER_CS)
c0101e00:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e03:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101e07:	66 83 f8 1b          	cmp    $0x1b,%ax
c0101e0b:	74 65                	je     c0101e72 <trap_dispatch+0x13c>
    	{
    		switchk2u = *tf;
c0101e0d:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e10:	ba 60 89 11 c0       	mov    $0xc0118960,%edx
c0101e15:	89 c3                	mov    %eax,%ebx
c0101e17:	b8 13 00 00 00       	mov    $0x13,%eax
c0101e1c:	89 d7                	mov    %edx,%edi
c0101e1e:	89 de                	mov    %ebx,%esi
c0101e20:	89 c1                	mov    %eax,%ecx
c0101e22:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    		switchk2u.tf_cs = USER_CS;
c0101e24:	66 c7 05 9c 89 11 c0 	movw   $0x1b,0xc011899c
c0101e2b:	1b 00 
    	    switchk2u.tf_ds = USER_DS;
c0101e2d:	66 c7 05 8c 89 11 c0 	movw   $0x23,0xc011898c
c0101e34:	23 00 
    	    switchk2u.tf_es = USER_DS;
c0101e36:	66 c7 05 88 89 11 c0 	movw   $0x23,0xc0118988
c0101e3d:	23 00 
    	    switchk2u.tf_ss = USER_DS;
c0101e3f:	66 c7 05 a8 89 11 c0 	movw   $0x23,0xc01189a8
c0101e46:	23 00 
    	    switchk2u.tf_esp = (uint32_t)tf + sizeof(struct trapframe) - 8;
c0101e48:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e4b:	83 c0 44             	add    $0x44,%eax
c0101e4e:	a3 a4 89 11 c0       	mov    %eax,0xc01189a4

    	    switchk2u.tf_eflags |= FL_IOPL_MASK;
c0101e53:	a1 a0 89 11 c0       	mov    0xc01189a0,%eax
c0101e58:	80 cc 30             	or     $0x30,%ah
c0101e5b:	a3 a0 89 11 c0       	mov    %eax,0xc01189a0

			*((uint32_t *)tf - 1) = (uint32_t)&switchk2u;
c0101e60:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e63:	8d 50 fc             	lea    -0x4(%eax),%edx
c0101e66:	b8 60 89 11 c0       	mov    $0xc0118960,%eax
c0101e6b:	89 02                	mov    %eax,(%edx)
		}
		break;
c0101e6d:	e9 b2 00 00 00       	jmp    c0101f24 <trap_dispatch+0x1ee>
c0101e72:	e9 ad 00 00 00       	jmp    c0101f24 <trap_dispatch+0x1ee>
    case T_SWITCH_TOK:
    	if (tf->tf_cs != KERNEL_CS)
c0101e77:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e7a:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101e7e:	66 83 f8 08          	cmp    $0x8,%ax
c0101e82:	74 65                	je     c0101ee9 <trap_dispatch+0x1b3>
    	{
			tf->tf_cs = KERNEL_CS;
c0101e84:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e87:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
			tf->tf_ds = KERNEL_DS;
c0101e8d:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e90:	66 c7 40 2c 10 00    	movw   $0x10,0x2c(%eax)
			tf->tf_es = KERNEL_DS;
c0101e96:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e99:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
			tf->tf_eflags &= ~FL_IOPL_MASK;
c0101e9f:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ea2:	8b 40 40             	mov    0x40(%eax),%eax
c0101ea5:	80 e4 cf             	and    $0xcf,%ah
c0101ea8:	89 c2                	mov    %eax,%edx
c0101eaa:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ead:	89 50 40             	mov    %edx,0x40(%eax)
			switchu2k = (struct trapframe *)(tf->tf_esp - (sizeof(struct trapframe) - 8));
c0101eb0:	8b 45 08             	mov    0x8(%ebp),%eax
c0101eb3:	8b 40 44             	mov    0x44(%eax),%eax
c0101eb6:	83 e8 44             	sub    $0x44,%eax
c0101eb9:	a3 ac 89 11 c0       	mov    %eax,0xc01189ac
			memmove(switchu2k, tf, sizeof(struct trapframe) - 8);
c0101ebe:	a1 ac 89 11 c0       	mov    0xc01189ac,%eax
c0101ec3:	c7 44 24 08 44 00 00 	movl   $0x44,0x8(%esp)
c0101eca:	00 
c0101ecb:	8b 55 08             	mov    0x8(%ebp),%edx
c0101ece:	89 54 24 04          	mov    %edx,0x4(%esp)
c0101ed2:	89 04 24             	mov    %eax,(%esp)
c0101ed5:	e8 9d 40 00 00       	call   c0105f77 <memmove>
			*((uint32_t *)tf - 1) = (uint32_t)switchu2k;
c0101eda:	8b 45 08             	mov    0x8(%ebp),%eax
c0101edd:	8d 50 fc             	lea    -0x4(%eax),%edx
c0101ee0:	a1 ac 89 11 c0       	mov    0xc01189ac,%eax
c0101ee5:	89 02                	mov    %eax,(%edx)
		}
        break;
c0101ee7:	eb 3b                	jmp    c0101f24 <trap_dispatch+0x1ee>
c0101ee9:	eb 39                	jmp    c0101f24 <trap_dispatch+0x1ee>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
c0101eeb:	8b 45 08             	mov    0x8(%ebp),%eax
c0101eee:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101ef2:	0f b7 c0             	movzwl %ax,%eax
c0101ef5:	83 e0 03             	and    $0x3,%eax
c0101ef8:	85 c0                	test   %eax,%eax
c0101efa:	75 28                	jne    c0101f24 <trap_dispatch+0x1ee>
            print_trapframe(tf);
c0101efc:	8b 45 08             	mov    0x8(%ebp),%eax
c0101eff:	89 04 24             	mov    %eax,(%esp)
c0101f02:	e8 b3 fb ff ff       	call   c0101aba <print_trapframe>
            panic("unexpected trap in kernel.\n");
c0101f07:	c7 44 24 08 4a 66 10 	movl   $0xc010664a,0x8(%esp)
c0101f0e:	c0 
c0101f0f:	c7 44 24 04 d4 00 00 	movl   $0xd4,0x4(%esp)
c0101f16:	00 
c0101f17:	c7 04 24 6e 64 10 c0 	movl   $0xc010646e,(%esp)
c0101f1e:	e8 f1 ed ff ff       	call   c0100d14 <__panic>
		}
        break;
    case IRQ_OFFSET + IRQ_IDE1:
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
c0101f23:	90                   	nop
        if ((tf->tf_cs & 3) == 0) {
            print_trapframe(tf);
            panic("unexpected trap in kernel.\n");
        }
    }
}
c0101f24:	83 c4 2c             	add    $0x2c,%esp
c0101f27:	5b                   	pop    %ebx
c0101f28:	5e                   	pop    %esi
c0101f29:	5f                   	pop    %edi
c0101f2a:	5d                   	pop    %ebp
c0101f2b:	c3                   	ret    

c0101f2c <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
c0101f2c:	55                   	push   %ebp
c0101f2d:	89 e5                	mov    %esp,%ebp
c0101f2f:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
c0101f32:	8b 45 08             	mov    0x8(%ebp),%eax
c0101f35:	89 04 24             	mov    %eax,(%esp)
c0101f38:	e8 f9 fd ff ff       	call   c0101d36 <trap_dispatch>
}
c0101f3d:	c9                   	leave  
c0101f3e:	c3                   	ret    

c0101f3f <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
c0101f3f:	1e                   	push   %ds
    pushl %es
c0101f40:	06                   	push   %es
    pushl %fs
c0101f41:	0f a0                	push   %fs
    pushl %gs
c0101f43:	0f a8                	push   %gs
    pushal
c0101f45:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
c0101f46:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
c0101f4b:	8e d8                	mov    %eax,%ds
    movw %ax, %es
c0101f4d:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
c0101f4f:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
c0101f50:	e8 d7 ff ff ff       	call   c0101f2c <trap>

    # pop the pushed stack pointer
    popl %esp
c0101f55:	5c                   	pop    %esp

c0101f56 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
c0101f56:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
c0101f57:	0f a9                	pop    %gs
    popl %fs
c0101f59:	0f a1                	pop    %fs
    popl %es
c0101f5b:	07                   	pop    %es
    popl %ds
c0101f5c:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
c0101f5d:	83 c4 08             	add    $0x8,%esp
    iret
c0101f60:	cf                   	iret   

c0101f61 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
c0101f61:	6a 00                	push   $0x0
  pushl $0
c0101f63:	6a 00                	push   $0x0
  jmp __alltraps
c0101f65:	e9 d5 ff ff ff       	jmp    c0101f3f <__alltraps>

c0101f6a <vector1>:
.globl vector1
vector1:
  pushl $0
c0101f6a:	6a 00                	push   $0x0
  pushl $1
c0101f6c:	6a 01                	push   $0x1
  jmp __alltraps
c0101f6e:	e9 cc ff ff ff       	jmp    c0101f3f <__alltraps>

c0101f73 <vector2>:
.globl vector2
vector2:
  pushl $0
c0101f73:	6a 00                	push   $0x0
  pushl $2
c0101f75:	6a 02                	push   $0x2
  jmp __alltraps
c0101f77:	e9 c3 ff ff ff       	jmp    c0101f3f <__alltraps>

c0101f7c <vector3>:
.globl vector3
vector3:
  pushl $0
c0101f7c:	6a 00                	push   $0x0
  pushl $3
c0101f7e:	6a 03                	push   $0x3
  jmp __alltraps
c0101f80:	e9 ba ff ff ff       	jmp    c0101f3f <__alltraps>

c0101f85 <vector4>:
.globl vector4
vector4:
  pushl $0
c0101f85:	6a 00                	push   $0x0
  pushl $4
c0101f87:	6a 04                	push   $0x4
  jmp __alltraps
c0101f89:	e9 b1 ff ff ff       	jmp    c0101f3f <__alltraps>

c0101f8e <vector5>:
.globl vector5
vector5:
  pushl $0
c0101f8e:	6a 00                	push   $0x0
  pushl $5
c0101f90:	6a 05                	push   $0x5
  jmp __alltraps
c0101f92:	e9 a8 ff ff ff       	jmp    c0101f3f <__alltraps>

c0101f97 <vector6>:
.globl vector6
vector6:
  pushl $0
c0101f97:	6a 00                	push   $0x0
  pushl $6
c0101f99:	6a 06                	push   $0x6
  jmp __alltraps
c0101f9b:	e9 9f ff ff ff       	jmp    c0101f3f <__alltraps>

c0101fa0 <vector7>:
.globl vector7
vector7:
  pushl $0
c0101fa0:	6a 00                	push   $0x0
  pushl $7
c0101fa2:	6a 07                	push   $0x7
  jmp __alltraps
c0101fa4:	e9 96 ff ff ff       	jmp    c0101f3f <__alltraps>

c0101fa9 <vector8>:
.globl vector8
vector8:
  pushl $8
c0101fa9:	6a 08                	push   $0x8
  jmp __alltraps
c0101fab:	e9 8f ff ff ff       	jmp    c0101f3f <__alltraps>

c0101fb0 <vector9>:
.globl vector9
vector9:
  pushl $9
c0101fb0:	6a 09                	push   $0x9
  jmp __alltraps
c0101fb2:	e9 88 ff ff ff       	jmp    c0101f3f <__alltraps>

c0101fb7 <vector10>:
.globl vector10
vector10:
  pushl $10
c0101fb7:	6a 0a                	push   $0xa
  jmp __alltraps
c0101fb9:	e9 81 ff ff ff       	jmp    c0101f3f <__alltraps>

c0101fbe <vector11>:
.globl vector11
vector11:
  pushl $11
c0101fbe:	6a 0b                	push   $0xb
  jmp __alltraps
c0101fc0:	e9 7a ff ff ff       	jmp    c0101f3f <__alltraps>

c0101fc5 <vector12>:
.globl vector12
vector12:
  pushl $12
c0101fc5:	6a 0c                	push   $0xc
  jmp __alltraps
c0101fc7:	e9 73 ff ff ff       	jmp    c0101f3f <__alltraps>

c0101fcc <vector13>:
.globl vector13
vector13:
  pushl $13
c0101fcc:	6a 0d                	push   $0xd
  jmp __alltraps
c0101fce:	e9 6c ff ff ff       	jmp    c0101f3f <__alltraps>

c0101fd3 <vector14>:
.globl vector14
vector14:
  pushl $14
c0101fd3:	6a 0e                	push   $0xe
  jmp __alltraps
c0101fd5:	e9 65 ff ff ff       	jmp    c0101f3f <__alltraps>

c0101fda <vector15>:
.globl vector15
vector15:
  pushl $0
c0101fda:	6a 00                	push   $0x0
  pushl $15
c0101fdc:	6a 0f                	push   $0xf
  jmp __alltraps
c0101fde:	e9 5c ff ff ff       	jmp    c0101f3f <__alltraps>

c0101fe3 <vector16>:
.globl vector16
vector16:
  pushl $0
c0101fe3:	6a 00                	push   $0x0
  pushl $16
c0101fe5:	6a 10                	push   $0x10
  jmp __alltraps
c0101fe7:	e9 53 ff ff ff       	jmp    c0101f3f <__alltraps>

c0101fec <vector17>:
.globl vector17
vector17:
  pushl $17
c0101fec:	6a 11                	push   $0x11
  jmp __alltraps
c0101fee:	e9 4c ff ff ff       	jmp    c0101f3f <__alltraps>

c0101ff3 <vector18>:
.globl vector18
vector18:
  pushl $0
c0101ff3:	6a 00                	push   $0x0
  pushl $18
c0101ff5:	6a 12                	push   $0x12
  jmp __alltraps
c0101ff7:	e9 43 ff ff ff       	jmp    c0101f3f <__alltraps>

c0101ffc <vector19>:
.globl vector19
vector19:
  pushl $0
c0101ffc:	6a 00                	push   $0x0
  pushl $19
c0101ffe:	6a 13                	push   $0x13
  jmp __alltraps
c0102000:	e9 3a ff ff ff       	jmp    c0101f3f <__alltraps>

c0102005 <vector20>:
.globl vector20
vector20:
  pushl $0
c0102005:	6a 00                	push   $0x0
  pushl $20
c0102007:	6a 14                	push   $0x14
  jmp __alltraps
c0102009:	e9 31 ff ff ff       	jmp    c0101f3f <__alltraps>

c010200e <vector21>:
.globl vector21
vector21:
  pushl $0
c010200e:	6a 00                	push   $0x0
  pushl $21
c0102010:	6a 15                	push   $0x15
  jmp __alltraps
c0102012:	e9 28 ff ff ff       	jmp    c0101f3f <__alltraps>

c0102017 <vector22>:
.globl vector22
vector22:
  pushl $0
c0102017:	6a 00                	push   $0x0
  pushl $22
c0102019:	6a 16                	push   $0x16
  jmp __alltraps
c010201b:	e9 1f ff ff ff       	jmp    c0101f3f <__alltraps>

c0102020 <vector23>:
.globl vector23
vector23:
  pushl $0
c0102020:	6a 00                	push   $0x0
  pushl $23
c0102022:	6a 17                	push   $0x17
  jmp __alltraps
c0102024:	e9 16 ff ff ff       	jmp    c0101f3f <__alltraps>

c0102029 <vector24>:
.globl vector24
vector24:
  pushl $0
c0102029:	6a 00                	push   $0x0
  pushl $24
c010202b:	6a 18                	push   $0x18
  jmp __alltraps
c010202d:	e9 0d ff ff ff       	jmp    c0101f3f <__alltraps>

c0102032 <vector25>:
.globl vector25
vector25:
  pushl $0
c0102032:	6a 00                	push   $0x0
  pushl $25
c0102034:	6a 19                	push   $0x19
  jmp __alltraps
c0102036:	e9 04 ff ff ff       	jmp    c0101f3f <__alltraps>

c010203b <vector26>:
.globl vector26
vector26:
  pushl $0
c010203b:	6a 00                	push   $0x0
  pushl $26
c010203d:	6a 1a                	push   $0x1a
  jmp __alltraps
c010203f:	e9 fb fe ff ff       	jmp    c0101f3f <__alltraps>

c0102044 <vector27>:
.globl vector27
vector27:
  pushl $0
c0102044:	6a 00                	push   $0x0
  pushl $27
c0102046:	6a 1b                	push   $0x1b
  jmp __alltraps
c0102048:	e9 f2 fe ff ff       	jmp    c0101f3f <__alltraps>

c010204d <vector28>:
.globl vector28
vector28:
  pushl $0
c010204d:	6a 00                	push   $0x0
  pushl $28
c010204f:	6a 1c                	push   $0x1c
  jmp __alltraps
c0102051:	e9 e9 fe ff ff       	jmp    c0101f3f <__alltraps>

c0102056 <vector29>:
.globl vector29
vector29:
  pushl $0
c0102056:	6a 00                	push   $0x0
  pushl $29
c0102058:	6a 1d                	push   $0x1d
  jmp __alltraps
c010205a:	e9 e0 fe ff ff       	jmp    c0101f3f <__alltraps>

c010205f <vector30>:
.globl vector30
vector30:
  pushl $0
c010205f:	6a 00                	push   $0x0
  pushl $30
c0102061:	6a 1e                	push   $0x1e
  jmp __alltraps
c0102063:	e9 d7 fe ff ff       	jmp    c0101f3f <__alltraps>

c0102068 <vector31>:
.globl vector31
vector31:
  pushl $0
c0102068:	6a 00                	push   $0x0
  pushl $31
c010206a:	6a 1f                	push   $0x1f
  jmp __alltraps
c010206c:	e9 ce fe ff ff       	jmp    c0101f3f <__alltraps>

c0102071 <vector32>:
.globl vector32
vector32:
  pushl $0
c0102071:	6a 00                	push   $0x0
  pushl $32
c0102073:	6a 20                	push   $0x20
  jmp __alltraps
c0102075:	e9 c5 fe ff ff       	jmp    c0101f3f <__alltraps>

c010207a <vector33>:
.globl vector33
vector33:
  pushl $0
c010207a:	6a 00                	push   $0x0
  pushl $33
c010207c:	6a 21                	push   $0x21
  jmp __alltraps
c010207e:	e9 bc fe ff ff       	jmp    c0101f3f <__alltraps>

c0102083 <vector34>:
.globl vector34
vector34:
  pushl $0
c0102083:	6a 00                	push   $0x0
  pushl $34
c0102085:	6a 22                	push   $0x22
  jmp __alltraps
c0102087:	e9 b3 fe ff ff       	jmp    c0101f3f <__alltraps>

c010208c <vector35>:
.globl vector35
vector35:
  pushl $0
c010208c:	6a 00                	push   $0x0
  pushl $35
c010208e:	6a 23                	push   $0x23
  jmp __alltraps
c0102090:	e9 aa fe ff ff       	jmp    c0101f3f <__alltraps>

c0102095 <vector36>:
.globl vector36
vector36:
  pushl $0
c0102095:	6a 00                	push   $0x0
  pushl $36
c0102097:	6a 24                	push   $0x24
  jmp __alltraps
c0102099:	e9 a1 fe ff ff       	jmp    c0101f3f <__alltraps>

c010209e <vector37>:
.globl vector37
vector37:
  pushl $0
c010209e:	6a 00                	push   $0x0
  pushl $37
c01020a0:	6a 25                	push   $0x25
  jmp __alltraps
c01020a2:	e9 98 fe ff ff       	jmp    c0101f3f <__alltraps>

c01020a7 <vector38>:
.globl vector38
vector38:
  pushl $0
c01020a7:	6a 00                	push   $0x0
  pushl $38
c01020a9:	6a 26                	push   $0x26
  jmp __alltraps
c01020ab:	e9 8f fe ff ff       	jmp    c0101f3f <__alltraps>

c01020b0 <vector39>:
.globl vector39
vector39:
  pushl $0
c01020b0:	6a 00                	push   $0x0
  pushl $39
c01020b2:	6a 27                	push   $0x27
  jmp __alltraps
c01020b4:	e9 86 fe ff ff       	jmp    c0101f3f <__alltraps>

c01020b9 <vector40>:
.globl vector40
vector40:
  pushl $0
c01020b9:	6a 00                	push   $0x0
  pushl $40
c01020bb:	6a 28                	push   $0x28
  jmp __alltraps
c01020bd:	e9 7d fe ff ff       	jmp    c0101f3f <__alltraps>

c01020c2 <vector41>:
.globl vector41
vector41:
  pushl $0
c01020c2:	6a 00                	push   $0x0
  pushl $41
c01020c4:	6a 29                	push   $0x29
  jmp __alltraps
c01020c6:	e9 74 fe ff ff       	jmp    c0101f3f <__alltraps>

c01020cb <vector42>:
.globl vector42
vector42:
  pushl $0
c01020cb:	6a 00                	push   $0x0
  pushl $42
c01020cd:	6a 2a                	push   $0x2a
  jmp __alltraps
c01020cf:	e9 6b fe ff ff       	jmp    c0101f3f <__alltraps>

c01020d4 <vector43>:
.globl vector43
vector43:
  pushl $0
c01020d4:	6a 00                	push   $0x0
  pushl $43
c01020d6:	6a 2b                	push   $0x2b
  jmp __alltraps
c01020d8:	e9 62 fe ff ff       	jmp    c0101f3f <__alltraps>

c01020dd <vector44>:
.globl vector44
vector44:
  pushl $0
c01020dd:	6a 00                	push   $0x0
  pushl $44
c01020df:	6a 2c                	push   $0x2c
  jmp __alltraps
c01020e1:	e9 59 fe ff ff       	jmp    c0101f3f <__alltraps>

c01020e6 <vector45>:
.globl vector45
vector45:
  pushl $0
c01020e6:	6a 00                	push   $0x0
  pushl $45
c01020e8:	6a 2d                	push   $0x2d
  jmp __alltraps
c01020ea:	e9 50 fe ff ff       	jmp    c0101f3f <__alltraps>

c01020ef <vector46>:
.globl vector46
vector46:
  pushl $0
c01020ef:	6a 00                	push   $0x0
  pushl $46
c01020f1:	6a 2e                	push   $0x2e
  jmp __alltraps
c01020f3:	e9 47 fe ff ff       	jmp    c0101f3f <__alltraps>

c01020f8 <vector47>:
.globl vector47
vector47:
  pushl $0
c01020f8:	6a 00                	push   $0x0
  pushl $47
c01020fa:	6a 2f                	push   $0x2f
  jmp __alltraps
c01020fc:	e9 3e fe ff ff       	jmp    c0101f3f <__alltraps>

c0102101 <vector48>:
.globl vector48
vector48:
  pushl $0
c0102101:	6a 00                	push   $0x0
  pushl $48
c0102103:	6a 30                	push   $0x30
  jmp __alltraps
c0102105:	e9 35 fe ff ff       	jmp    c0101f3f <__alltraps>

c010210a <vector49>:
.globl vector49
vector49:
  pushl $0
c010210a:	6a 00                	push   $0x0
  pushl $49
c010210c:	6a 31                	push   $0x31
  jmp __alltraps
c010210e:	e9 2c fe ff ff       	jmp    c0101f3f <__alltraps>

c0102113 <vector50>:
.globl vector50
vector50:
  pushl $0
c0102113:	6a 00                	push   $0x0
  pushl $50
c0102115:	6a 32                	push   $0x32
  jmp __alltraps
c0102117:	e9 23 fe ff ff       	jmp    c0101f3f <__alltraps>

c010211c <vector51>:
.globl vector51
vector51:
  pushl $0
c010211c:	6a 00                	push   $0x0
  pushl $51
c010211e:	6a 33                	push   $0x33
  jmp __alltraps
c0102120:	e9 1a fe ff ff       	jmp    c0101f3f <__alltraps>

c0102125 <vector52>:
.globl vector52
vector52:
  pushl $0
c0102125:	6a 00                	push   $0x0
  pushl $52
c0102127:	6a 34                	push   $0x34
  jmp __alltraps
c0102129:	e9 11 fe ff ff       	jmp    c0101f3f <__alltraps>

c010212e <vector53>:
.globl vector53
vector53:
  pushl $0
c010212e:	6a 00                	push   $0x0
  pushl $53
c0102130:	6a 35                	push   $0x35
  jmp __alltraps
c0102132:	e9 08 fe ff ff       	jmp    c0101f3f <__alltraps>

c0102137 <vector54>:
.globl vector54
vector54:
  pushl $0
c0102137:	6a 00                	push   $0x0
  pushl $54
c0102139:	6a 36                	push   $0x36
  jmp __alltraps
c010213b:	e9 ff fd ff ff       	jmp    c0101f3f <__alltraps>

c0102140 <vector55>:
.globl vector55
vector55:
  pushl $0
c0102140:	6a 00                	push   $0x0
  pushl $55
c0102142:	6a 37                	push   $0x37
  jmp __alltraps
c0102144:	e9 f6 fd ff ff       	jmp    c0101f3f <__alltraps>

c0102149 <vector56>:
.globl vector56
vector56:
  pushl $0
c0102149:	6a 00                	push   $0x0
  pushl $56
c010214b:	6a 38                	push   $0x38
  jmp __alltraps
c010214d:	e9 ed fd ff ff       	jmp    c0101f3f <__alltraps>

c0102152 <vector57>:
.globl vector57
vector57:
  pushl $0
c0102152:	6a 00                	push   $0x0
  pushl $57
c0102154:	6a 39                	push   $0x39
  jmp __alltraps
c0102156:	e9 e4 fd ff ff       	jmp    c0101f3f <__alltraps>

c010215b <vector58>:
.globl vector58
vector58:
  pushl $0
c010215b:	6a 00                	push   $0x0
  pushl $58
c010215d:	6a 3a                	push   $0x3a
  jmp __alltraps
c010215f:	e9 db fd ff ff       	jmp    c0101f3f <__alltraps>

c0102164 <vector59>:
.globl vector59
vector59:
  pushl $0
c0102164:	6a 00                	push   $0x0
  pushl $59
c0102166:	6a 3b                	push   $0x3b
  jmp __alltraps
c0102168:	e9 d2 fd ff ff       	jmp    c0101f3f <__alltraps>

c010216d <vector60>:
.globl vector60
vector60:
  pushl $0
c010216d:	6a 00                	push   $0x0
  pushl $60
c010216f:	6a 3c                	push   $0x3c
  jmp __alltraps
c0102171:	e9 c9 fd ff ff       	jmp    c0101f3f <__alltraps>

c0102176 <vector61>:
.globl vector61
vector61:
  pushl $0
c0102176:	6a 00                	push   $0x0
  pushl $61
c0102178:	6a 3d                	push   $0x3d
  jmp __alltraps
c010217a:	e9 c0 fd ff ff       	jmp    c0101f3f <__alltraps>

c010217f <vector62>:
.globl vector62
vector62:
  pushl $0
c010217f:	6a 00                	push   $0x0
  pushl $62
c0102181:	6a 3e                	push   $0x3e
  jmp __alltraps
c0102183:	e9 b7 fd ff ff       	jmp    c0101f3f <__alltraps>

c0102188 <vector63>:
.globl vector63
vector63:
  pushl $0
c0102188:	6a 00                	push   $0x0
  pushl $63
c010218a:	6a 3f                	push   $0x3f
  jmp __alltraps
c010218c:	e9 ae fd ff ff       	jmp    c0101f3f <__alltraps>

c0102191 <vector64>:
.globl vector64
vector64:
  pushl $0
c0102191:	6a 00                	push   $0x0
  pushl $64
c0102193:	6a 40                	push   $0x40
  jmp __alltraps
c0102195:	e9 a5 fd ff ff       	jmp    c0101f3f <__alltraps>

c010219a <vector65>:
.globl vector65
vector65:
  pushl $0
c010219a:	6a 00                	push   $0x0
  pushl $65
c010219c:	6a 41                	push   $0x41
  jmp __alltraps
c010219e:	e9 9c fd ff ff       	jmp    c0101f3f <__alltraps>

c01021a3 <vector66>:
.globl vector66
vector66:
  pushl $0
c01021a3:	6a 00                	push   $0x0
  pushl $66
c01021a5:	6a 42                	push   $0x42
  jmp __alltraps
c01021a7:	e9 93 fd ff ff       	jmp    c0101f3f <__alltraps>

c01021ac <vector67>:
.globl vector67
vector67:
  pushl $0
c01021ac:	6a 00                	push   $0x0
  pushl $67
c01021ae:	6a 43                	push   $0x43
  jmp __alltraps
c01021b0:	e9 8a fd ff ff       	jmp    c0101f3f <__alltraps>

c01021b5 <vector68>:
.globl vector68
vector68:
  pushl $0
c01021b5:	6a 00                	push   $0x0
  pushl $68
c01021b7:	6a 44                	push   $0x44
  jmp __alltraps
c01021b9:	e9 81 fd ff ff       	jmp    c0101f3f <__alltraps>

c01021be <vector69>:
.globl vector69
vector69:
  pushl $0
c01021be:	6a 00                	push   $0x0
  pushl $69
c01021c0:	6a 45                	push   $0x45
  jmp __alltraps
c01021c2:	e9 78 fd ff ff       	jmp    c0101f3f <__alltraps>

c01021c7 <vector70>:
.globl vector70
vector70:
  pushl $0
c01021c7:	6a 00                	push   $0x0
  pushl $70
c01021c9:	6a 46                	push   $0x46
  jmp __alltraps
c01021cb:	e9 6f fd ff ff       	jmp    c0101f3f <__alltraps>

c01021d0 <vector71>:
.globl vector71
vector71:
  pushl $0
c01021d0:	6a 00                	push   $0x0
  pushl $71
c01021d2:	6a 47                	push   $0x47
  jmp __alltraps
c01021d4:	e9 66 fd ff ff       	jmp    c0101f3f <__alltraps>

c01021d9 <vector72>:
.globl vector72
vector72:
  pushl $0
c01021d9:	6a 00                	push   $0x0
  pushl $72
c01021db:	6a 48                	push   $0x48
  jmp __alltraps
c01021dd:	e9 5d fd ff ff       	jmp    c0101f3f <__alltraps>

c01021e2 <vector73>:
.globl vector73
vector73:
  pushl $0
c01021e2:	6a 00                	push   $0x0
  pushl $73
c01021e4:	6a 49                	push   $0x49
  jmp __alltraps
c01021e6:	e9 54 fd ff ff       	jmp    c0101f3f <__alltraps>

c01021eb <vector74>:
.globl vector74
vector74:
  pushl $0
c01021eb:	6a 00                	push   $0x0
  pushl $74
c01021ed:	6a 4a                	push   $0x4a
  jmp __alltraps
c01021ef:	e9 4b fd ff ff       	jmp    c0101f3f <__alltraps>

c01021f4 <vector75>:
.globl vector75
vector75:
  pushl $0
c01021f4:	6a 00                	push   $0x0
  pushl $75
c01021f6:	6a 4b                	push   $0x4b
  jmp __alltraps
c01021f8:	e9 42 fd ff ff       	jmp    c0101f3f <__alltraps>

c01021fd <vector76>:
.globl vector76
vector76:
  pushl $0
c01021fd:	6a 00                	push   $0x0
  pushl $76
c01021ff:	6a 4c                	push   $0x4c
  jmp __alltraps
c0102201:	e9 39 fd ff ff       	jmp    c0101f3f <__alltraps>

c0102206 <vector77>:
.globl vector77
vector77:
  pushl $0
c0102206:	6a 00                	push   $0x0
  pushl $77
c0102208:	6a 4d                	push   $0x4d
  jmp __alltraps
c010220a:	e9 30 fd ff ff       	jmp    c0101f3f <__alltraps>

c010220f <vector78>:
.globl vector78
vector78:
  pushl $0
c010220f:	6a 00                	push   $0x0
  pushl $78
c0102211:	6a 4e                	push   $0x4e
  jmp __alltraps
c0102213:	e9 27 fd ff ff       	jmp    c0101f3f <__alltraps>

c0102218 <vector79>:
.globl vector79
vector79:
  pushl $0
c0102218:	6a 00                	push   $0x0
  pushl $79
c010221a:	6a 4f                	push   $0x4f
  jmp __alltraps
c010221c:	e9 1e fd ff ff       	jmp    c0101f3f <__alltraps>

c0102221 <vector80>:
.globl vector80
vector80:
  pushl $0
c0102221:	6a 00                	push   $0x0
  pushl $80
c0102223:	6a 50                	push   $0x50
  jmp __alltraps
c0102225:	e9 15 fd ff ff       	jmp    c0101f3f <__alltraps>

c010222a <vector81>:
.globl vector81
vector81:
  pushl $0
c010222a:	6a 00                	push   $0x0
  pushl $81
c010222c:	6a 51                	push   $0x51
  jmp __alltraps
c010222e:	e9 0c fd ff ff       	jmp    c0101f3f <__alltraps>

c0102233 <vector82>:
.globl vector82
vector82:
  pushl $0
c0102233:	6a 00                	push   $0x0
  pushl $82
c0102235:	6a 52                	push   $0x52
  jmp __alltraps
c0102237:	e9 03 fd ff ff       	jmp    c0101f3f <__alltraps>

c010223c <vector83>:
.globl vector83
vector83:
  pushl $0
c010223c:	6a 00                	push   $0x0
  pushl $83
c010223e:	6a 53                	push   $0x53
  jmp __alltraps
c0102240:	e9 fa fc ff ff       	jmp    c0101f3f <__alltraps>

c0102245 <vector84>:
.globl vector84
vector84:
  pushl $0
c0102245:	6a 00                	push   $0x0
  pushl $84
c0102247:	6a 54                	push   $0x54
  jmp __alltraps
c0102249:	e9 f1 fc ff ff       	jmp    c0101f3f <__alltraps>

c010224e <vector85>:
.globl vector85
vector85:
  pushl $0
c010224e:	6a 00                	push   $0x0
  pushl $85
c0102250:	6a 55                	push   $0x55
  jmp __alltraps
c0102252:	e9 e8 fc ff ff       	jmp    c0101f3f <__alltraps>

c0102257 <vector86>:
.globl vector86
vector86:
  pushl $0
c0102257:	6a 00                	push   $0x0
  pushl $86
c0102259:	6a 56                	push   $0x56
  jmp __alltraps
c010225b:	e9 df fc ff ff       	jmp    c0101f3f <__alltraps>

c0102260 <vector87>:
.globl vector87
vector87:
  pushl $0
c0102260:	6a 00                	push   $0x0
  pushl $87
c0102262:	6a 57                	push   $0x57
  jmp __alltraps
c0102264:	e9 d6 fc ff ff       	jmp    c0101f3f <__alltraps>

c0102269 <vector88>:
.globl vector88
vector88:
  pushl $0
c0102269:	6a 00                	push   $0x0
  pushl $88
c010226b:	6a 58                	push   $0x58
  jmp __alltraps
c010226d:	e9 cd fc ff ff       	jmp    c0101f3f <__alltraps>

c0102272 <vector89>:
.globl vector89
vector89:
  pushl $0
c0102272:	6a 00                	push   $0x0
  pushl $89
c0102274:	6a 59                	push   $0x59
  jmp __alltraps
c0102276:	e9 c4 fc ff ff       	jmp    c0101f3f <__alltraps>

c010227b <vector90>:
.globl vector90
vector90:
  pushl $0
c010227b:	6a 00                	push   $0x0
  pushl $90
c010227d:	6a 5a                	push   $0x5a
  jmp __alltraps
c010227f:	e9 bb fc ff ff       	jmp    c0101f3f <__alltraps>

c0102284 <vector91>:
.globl vector91
vector91:
  pushl $0
c0102284:	6a 00                	push   $0x0
  pushl $91
c0102286:	6a 5b                	push   $0x5b
  jmp __alltraps
c0102288:	e9 b2 fc ff ff       	jmp    c0101f3f <__alltraps>

c010228d <vector92>:
.globl vector92
vector92:
  pushl $0
c010228d:	6a 00                	push   $0x0
  pushl $92
c010228f:	6a 5c                	push   $0x5c
  jmp __alltraps
c0102291:	e9 a9 fc ff ff       	jmp    c0101f3f <__alltraps>

c0102296 <vector93>:
.globl vector93
vector93:
  pushl $0
c0102296:	6a 00                	push   $0x0
  pushl $93
c0102298:	6a 5d                	push   $0x5d
  jmp __alltraps
c010229a:	e9 a0 fc ff ff       	jmp    c0101f3f <__alltraps>

c010229f <vector94>:
.globl vector94
vector94:
  pushl $0
c010229f:	6a 00                	push   $0x0
  pushl $94
c01022a1:	6a 5e                	push   $0x5e
  jmp __alltraps
c01022a3:	e9 97 fc ff ff       	jmp    c0101f3f <__alltraps>

c01022a8 <vector95>:
.globl vector95
vector95:
  pushl $0
c01022a8:	6a 00                	push   $0x0
  pushl $95
c01022aa:	6a 5f                	push   $0x5f
  jmp __alltraps
c01022ac:	e9 8e fc ff ff       	jmp    c0101f3f <__alltraps>

c01022b1 <vector96>:
.globl vector96
vector96:
  pushl $0
c01022b1:	6a 00                	push   $0x0
  pushl $96
c01022b3:	6a 60                	push   $0x60
  jmp __alltraps
c01022b5:	e9 85 fc ff ff       	jmp    c0101f3f <__alltraps>

c01022ba <vector97>:
.globl vector97
vector97:
  pushl $0
c01022ba:	6a 00                	push   $0x0
  pushl $97
c01022bc:	6a 61                	push   $0x61
  jmp __alltraps
c01022be:	e9 7c fc ff ff       	jmp    c0101f3f <__alltraps>

c01022c3 <vector98>:
.globl vector98
vector98:
  pushl $0
c01022c3:	6a 00                	push   $0x0
  pushl $98
c01022c5:	6a 62                	push   $0x62
  jmp __alltraps
c01022c7:	e9 73 fc ff ff       	jmp    c0101f3f <__alltraps>

c01022cc <vector99>:
.globl vector99
vector99:
  pushl $0
c01022cc:	6a 00                	push   $0x0
  pushl $99
c01022ce:	6a 63                	push   $0x63
  jmp __alltraps
c01022d0:	e9 6a fc ff ff       	jmp    c0101f3f <__alltraps>

c01022d5 <vector100>:
.globl vector100
vector100:
  pushl $0
c01022d5:	6a 00                	push   $0x0
  pushl $100
c01022d7:	6a 64                	push   $0x64
  jmp __alltraps
c01022d9:	e9 61 fc ff ff       	jmp    c0101f3f <__alltraps>

c01022de <vector101>:
.globl vector101
vector101:
  pushl $0
c01022de:	6a 00                	push   $0x0
  pushl $101
c01022e0:	6a 65                	push   $0x65
  jmp __alltraps
c01022e2:	e9 58 fc ff ff       	jmp    c0101f3f <__alltraps>

c01022e7 <vector102>:
.globl vector102
vector102:
  pushl $0
c01022e7:	6a 00                	push   $0x0
  pushl $102
c01022e9:	6a 66                	push   $0x66
  jmp __alltraps
c01022eb:	e9 4f fc ff ff       	jmp    c0101f3f <__alltraps>

c01022f0 <vector103>:
.globl vector103
vector103:
  pushl $0
c01022f0:	6a 00                	push   $0x0
  pushl $103
c01022f2:	6a 67                	push   $0x67
  jmp __alltraps
c01022f4:	e9 46 fc ff ff       	jmp    c0101f3f <__alltraps>

c01022f9 <vector104>:
.globl vector104
vector104:
  pushl $0
c01022f9:	6a 00                	push   $0x0
  pushl $104
c01022fb:	6a 68                	push   $0x68
  jmp __alltraps
c01022fd:	e9 3d fc ff ff       	jmp    c0101f3f <__alltraps>

c0102302 <vector105>:
.globl vector105
vector105:
  pushl $0
c0102302:	6a 00                	push   $0x0
  pushl $105
c0102304:	6a 69                	push   $0x69
  jmp __alltraps
c0102306:	e9 34 fc ff ff       	jmp    c0101f3f <__alltraps>

c010230b <vector106>:
.globl vector106
vector106:
  pushl $0
c010230b:	6a 00                	push   $0x0
  pushl $106
c010230d:	6a 6a                	push   $0x6a
  jmp __alltraps
c010230f:	e9 2b fc ff ff       	jmp    c0101f3f <__alltraps>

c0102314 <vector107>:
.globl vector107
vector107:
  pushl $0
c0102314:	6a 00                	push   $0x0
  pushl $107
c0102316:	6a 6b                	push   $0x6b
  jmp __alltraps
c0102318:	e9 22 fc ff ff       	jmp    c0101f3f <__alltraps>

c010231d <vector108>:
.globl vector108
vector108:
  pushl $0
c010231d:	6a 00                	push   $0x0
  pushl $108
c010231f:	6a 6c                	push   $0x6c
  jmp __alltraps
c0102321:	e9 19 fc ff ff       	jmp    c0101f3f <__alltraps>

c0102326 <vector109>:
.globl vector109
vector109:
  pushl $0
c0102326:	6a 00                	push   $0x0
  pushl $109
c0102328:	6a 6d                	push   $0x6d
  jmp __alltraps
c010232a:	e9 10 fc ff ff       	jmp    c0101f3f <__alltraps>

c010232f <vector110>:
.globl vector110
vector110:
  pushl $0
c010232f:	6a 00                	push   $0x0
  pushl $110
c0102331:	6a 6e                	push   $0x6e
  jmp __alltraps
c0102333:	e9 07 fc ff ff       	jmp    c0101f3f <__alltraps>

c0102338 <vector111>:
.globl vector111
vector111:
  pushl $0
c0102338:	6a 00                	push   $0x0
  pushl $111
c010233a:	6a 6f                	push   $0x6f
  jmp __alltraps
c010233c:	e9 fe fb ff ff       	jmp    c0101f3f <__alltraps>

c0102341 <vector112>:
.globl vector112
vector112:
  pushl $0
c0102341:	6a 00                	push   $0x0
  pushl $112
c0102343:	6a 70                	push   $0x70
  jmp __alltraps
c0102345:	e9 f5 fb ff ff       	jmp    c0101f3f <__alltraps>

c010234a <vector113>:
.globl vector113
vector113:
  pushl $0
c010234a:	6a 00                	push   $0x0
  pushl $113
c010234c:	6a 71                	push   $0x71
  jmp __alltraps
c010234e:	e9 ec fb ff ff       	jmp    c0101f3f <__alltraps>

c0102353 <vector114>:
.globl vector114
vector114:
  pushl $0
c0102353:	6a 00                	push   $0x0
  pushl $114
c0102355:	6a 72                	push   $0x72
  jmp __alltraps
c0102357:	e9 e3 fb ff ff       	jmp    c0101f3f <__alltraps>

c010235c <vector115>:
.globl vector115
vector115:
  pushl $0
c010235c:	6a 00                	push   $0x0
  pushl $115
c010235e:	6a 73                	push   $0x73
  jmp __alltraps
c0102360:	e9 da fb ff ff       	jmp    c0101f3f <__alltraps>

c0102365 <vector116>:
.globl vector116
vector116:
  pushl $0
c0102365:	6a 00                	push   $0x0
  pushl $116
c0102367:	6a 74                	push   $0x74
  jmp __alltraps
c0102369:	e9 d1 fb ff ff       	jmp    c0101f3f <__alltraps>

c010236e <vector117>:
.globl vector117
vector117:
  pushl $0
c010236e:	6a 00                	push   $0x0
  pushl $117
c0102370:	6a 75                	push   $0x75
  jmp __alltraps
c0102372:	e9 c8 fb ff ff       	jmp    c0101f3f <__alltraps>

c0102377 <vector118>:
.globl vector118
vector118:
  pushl $0
c0102377:	6a 00                	push   $0x0
  pushl $118
c0102379:	6a 76                	push   $0x76
  jmp __alltraps
c010237b:	e9 bf fb ff ff       	jmp    c0101f3f <__alltraps>

c0102380 <vector119>:
.globl vector119
vector119:
  pushl $0
c0102380:	6a 00                	push   $0x0
  pushl $119
c0102382:	6a 77                	push   $0x77
  jmp __alltraps
c0102384:	e9 b6 fb ff ff       	jmp    c0101f3f <__alltraps>

c0102389 <vector120>:
.globl vector120
vector120:
  pushl $0
c0102389:	6a 00                	push   $0x0
  pushl $120
c010238b:	6a 78                	push   $0x78
  jmp __alltraps
c010238d:	e9 ad fb ff ff       	jmp    c0101f3f <__alltraps>

c0102392 <vector121>:
.globl vector121
vector121:
  pushl $0
c0102392:	6a 00                	push   $0x0
  pushl $121
c0102394:	6a 79                	push   $0x79
  jmp __alltraps
c0102396:	e9 a4 fb ff ff       	jmp    c0101f3f <__alltraps>

c010239b <vector122>:
.globl vector122
vector122:
  pushl $0
c010239b:	6a 00                	push   $0x0
  pushl $122
c010239d:	6a 7a                	push   $0x7a
  jmp __alltraps
c010239f:	e9 9b fb ff ff       	jmp    c0101f3f <__alltraps>

c01023a4 <vector123>:
.globl vector123
vector123:
  pushl $0
c01023a4:	6a 00                	push   $0x0
  pushl $123
c01023a6:	6a 7b                	push   $0x7b
  jmp __alltraps
c01023a8:	e9 92 fb ff ff       	jmp    c0101f3f <__alltraps>

c01023ad <vector124>:
.globl vector124
vector124:
  pushl $0
c01023ad:	6a 00                	push   $0x0
  pushl $124
c01023af:	6a 7c                	push   $0x7c
  jmp __alltraps
c01023b1:	e9 89 fb ff ff       	jmp    c0101f3f <__alltraps>

c01023b6 <vector125>:
.globl vector125
vector125:
  pushl $0
c01023b6:	6a 00                	push   $0x0
  pushl $125
c01023b8:	6a 7d                	push   $0x7d
  jmp __alltraps
c01023ba:	e9 80 fb ff ff       	jmp    c0101f3f <__alltraps>

c01023bf <vector126>:
.globl vector126
vector126:
  pushl $0
c01023bf:	6a 00                	push   $0x0
  pushl $126
c01023c1:	6a 7e                	push   $0x7e
  jmp __alltraps
c01023c3:	e9 77 fb ff ff       	jmp    c0101f3f <__alltraps>

c01023c8 <vector127>:
.globl vector127
vector127:
  pushl $0
c01023c8:	6a 00                	push   $0x0
  pushl $127
c01023ca:	6a 7f                	push   $0x7f
  jmp __alltraps
c01023cc:	e9 6e fb ff ff       	jmp    c0101f3f <__alltraps>

c01023d1 <vector128>:
.globl vector128
vector128:
  pushl $0
c01023d1:	6a 00                	push   $0x0
  pushl $128
c01023d3:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
c01023d8:	e9 62 fb ff ff       	jmp    c0101f3f <__alltraps>

c01023dd <vector129>:
.globl vector129
vector129:
  pushl $0
c01023dd:	6a 00                	push   $0x0
  pushl $129
c01023df:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
c01023e4:	e9 56 fb ff ff       	jmp    c0101f3f <__alltraps>

c01023e9 <vector130>:
.globl vector130
vector130:
  pushl $0
c01023e9:	6a 00                	push   $0x0
  pushl $130
c01023eb:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
c01023f0:	e9 4a fb ff ff       	jmp    c0101f3f <__alltraps>

c01023f5 <vector131>:
.globl vector131
vector131:
  pushl $0
c01023f5:	6a 00                	push   $0x0
  pushl $131
c01023f7:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
c01023fc:	e9 3e fb ff ff       	jmp    c0101f3f <__alltraps>

c0102401 <vector132>:
.globl vector132
vector132:
  pushl $0
c0102401:	6a 00                	push   $0x0
  pushl $132
c0102403:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
c0102408:	e9 32 fb ff ff       	jmp    c0101f3f <__alltraps>

c010240d <vector133>:
.globl vector133
vector133:
  pushl $0
c010240d:	6a 00                	push   $0x0
  pushl $133
c010240f:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
c0102414:	e9 26 fb ff ff       	jmp    c0101f3f <__alltraps>

c0102419 <vector134>:
.globl vector134
vector134:
  pushl $0
c0102419:	6a 00                	push   $0x0
  pushl $134
c010241b:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
c0102420:	e9 1a fb ff ff       	jmp    c0101f3f <__alltraps>

c0102425 <vector135>:
.globl vector135
vector135:
  pushl $0
c0102425:	6a 00                	push   $0x0
  pushl $135
c0102427:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
c010242c:	e9 0e fb ff ff       	jmp    c0101f3f <__alltraps>

c0102431 <vector136>:
.globl vector136
vector136:
  pushl $0
c0102431:	6a 00                	push   $0x0
  pushl $136
c0102433:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
c0102438:	e9 02 fb ff ff       	jmp    c0101f3f <__alltraps>

c010243d <vector137>:
.globl vector137
vector137:
  pushl $0
c010243d:	6a 00                	push   $0x0
  pushl $137
c010243f:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
c0102444:	e9 f6 fa ff ff       	jmp    c0101f3f <__alltraps>

c0102449 <vector138>:
.globl vector138
vector138:
  pushl $0
c0102449:	6a 00                	push   $0x0
  pushl $138
c010244b:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
c0102450:	e9 ea fa ff ff       	jmp    c0101f3f <__alltraps>

c0102455 <vector139>:
.globl vector139
vector139:
  pushl $0
c0102455:	6a 00                	push   $0x0
  pushl $139
c0102457:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
c010245c:	e9 de fa ff ff       	jmp    c0101f3f <__alltraps>

c0102461 <vector140>:
.globl vector140
vector140:
  pushl $0
c0102461:	6a 00                	push   $0x0
  pushl $140
c0102463:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
c0102468:	e9 d2 fa ff ff       	jmp    c0101f3f <__alltraps>

c010246d <vector141>:
.globl vector141
vector141:
  pushl $0
c010246d:	6a 00                	push   $0x0
  pushl $141
c010246f:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
c0102474:	e9 c6 fa ff ff       	jmp    c0101f3f <__alltraps>

c0102479 <vector142>:
.globl vector142
vector142:
  pushl $0
c0102479:	6a 00                	push   $0x0
  pushl $142
c010247b:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
c0102480:	e9 ba fa ff ff       	jmp    c0101f3f <__alltraps>

c0102485 <vector143>:
.globl vector143
vector143:
  pushl $0
c0102485:	6a 00                	push   $0x0
  pushl $143
c0102487:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
c010248c:	e9 ae fa ff ff       	jmp    c0101f3f <__alltraps>

c0102491 <vector144>:
.globl vector144
vector144:
  pushl $0
c0102491:	6a 00                	push   $0x0
  pushl $144
c0102493:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
c0102498:	e9 a2 fa ff ff       	jmp    c0101f3f <__alltraps>

c010249d <vector145>:
.globl vector145
vector145:
  pushl $0
c010249d:	6a 00                	push   $0x0
  pushl $145
c010249f:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
c01024a4:	e9 96 fa ff ff       	jmp    c0101f3f <__alltraps>

c01024a9 <vector146>:
.globl vector146
vector146:
  pushl $0
c01024a9:	6a 00                	push   $0x0
  pushl $146
c01024ab:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
c01024b0:	e9 8a fa ff ff       	jmp    c0101f3f <__alltraps>

c01024b5 <vector147>:
.globl vector147
vector147:
  pushl $0
c01024b5:	6a 00                	push   $0x0
  pushl $147
c01024b7:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
c01024bc:	e9 7e fa ff ff       	jmp    c0101f3f <__alltraps>

c01024c1 <vector148>:
.globl vector148
vector148:
  pushl $0
c01024c1:	6a 00                	push   $0x0
  pushl $148
c01024c3:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
c01024c8:	e9 72 fa ff ff       	jmp    c0101f3f <__alltraps>

c01024cd <vector149>:
.globl vector149
vector149:
  pushl $0
c01024cd:	6a 00                	push   $0x0
  pushl $149
c01024cf:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
c01024d4:	e9 66 fa ff ff       	jmp    c0101f3f <__alltraps>

c01024d9 <vector150>:
.globl vector150
vector150:
  pushl $0
c01024d9:	6a 00                	push   $0x0
  pushl $150
c01024db:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
c01024e0:	e9 5a fa ff ff       	jmp    c0101f3f <__alltraps>

c01024e5 <vector151>:
.globl vector151
vector151:
  pushl $0
c01024e5:	6a 00                	push   $0x0
  pushl $151
c01024e7:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
c01024ec:	e9 4e fa ff ff       	jmp    c0101f3f <__alltraps>

c01024f1 <vector152>:
.globl vector152
vector152:
  pushl $0
c01024f1:	6a 00                	push   $0x0
  pushl $152
c01024f3:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
c01024f8:	e9 42 fa ff ff       	jmp    c0101f3f <__alltraps>

c01024fd <vector153>:
.globl vector153
vector153:
  pushl $0
c01024fd:	6a 00                	push   $0x0
  pushl $153
c01024ff:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
c0102504:	e9 36 fa ff ff       	jmp    c0101f3f <__alltraps>

c0102509 <vector154>:
.globl vector154
vector154:
  pushl $0
c0102509:	6a 00                	push   $0x0
  pushl $154
c010250b:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
c0102510:	e9 2a fa ff ff       	jmp    c0101f3f <__alltraps>

c0102515 <vector155>:
.globl vector155
vector155:
  pushl $0
c0102515:	6a 00                	push   $0x0
  pushl $155
c0102517:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
c010251c:	e9 1e fa ff ff       	jmp    c0101f3f <__alltraps>

c0102521 <vector156>:
.globl vector156
vector156:
  pushl $0
c0102521:	6a 00                	push   $0x0
  pushl $156
c0102523:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
c0102528:	e9 12 fa ff ff       	jmp    c0101f3f <__alltraps>

c010252d <vector157>:
.globl vector157
vector157:
  pushl $0
c010252d:	6a 00                	push   $0x0
  pushl $157
c010252f:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
c0102534:	e9 06 fa ff ff       	jmp    c0101f3f <__alltraps>

c0102539 <vector158>:
.globl vector158
vector158:
  pushl $0
c0102539:	6a 00                	push   $0x0
  pushl $158
c010253b:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
c0102540:	e9 fa f9 ff ff       	jmp    c0101f3f <__alltraps>

c0102545 <vector159>:
.globl vector159
vector159:
  pushl $0
c0102545:	6a 00                	push   $0x0
  pushl $159
c0102547:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
c010254c:	e9 ee f9 ff ff       	jmp    c0101f3f <__alltraps>

c0102551 <vector160>:
.globl vector160
vector160:
  pushl $0
c0102551:	6a 00                	push   $0x0
  pushl $160
c0102553:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
c0102558:	e9 e2 f9 ff ff       	jmp    c0101f3f <__alltraps>

c010255d <vector161>:
.globl vector161
vector161:
  pushl $0
c010255d:	6a 00                	push   $0x0
  pushl $161
c010255f:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
c0102564:	e9 d6 f9 ff ff       	jmp    c0101f3f <__alltraps>

c0102569 <vector162>:
.globl vector162
vector162:
  pushl $0
c0102569:	6a 00                	push   $0x0
  pushl $162
c010256b:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
c0102570:	e9 ca f9 ff ff       	jmp    c0101f3f <__alltraps>

c0102575 <vector163>:
.globl vector163
vector163:
  pushl $0
c0102575:	6a 00                	push   $0x0
  pushl $163
c0102577:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
c010257c:	e9 be f9 ff ff       	jmp    c0101f3f <__alltraps>

c0102581 <vector164>:
.globl vector164
vector164:
  pushl $0
c0102581:	6a 00                	push   $0x0
  pushl $164
c0102583:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
c0102588:	e9 b2 f9 ff ff       	jmp    c0101f3f <__alltraps>

c010258d <vector165>:
.globl vector165
vector165:
  pushl $0
c010258d:	6a 00                	push   $0x0
  pushl $165
c010258f:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
c0102594:	e9 a6 f9 ff ff       	jmp    c0101f3f <__alltraps>

c0102599 <vector166>:
.globl vector166
vector166:
  pushl $0
c0102599:	6a 00                	push   $0x0
  pushl $166
c010259b:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
c01025a0:	e9 9a f9 ff ff       	jmp    c0101f3f <__alltraps>

c01025a5 <vector167>:
.globl vector167
vector167:
  pushl $0
c01025a5:	6a 00                	push   $0x0
  pushl $167
c01025a7:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
c01025ac:	e9 8e f9 ff ff       	jmp    c0101f3f <__alltraps>

c01025b1 <vector168>:
.globl vector168
vector168:
  pushl $0
c01025b1:	6a 00                	push   $0x0
  pushl $168
c01025b3:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
c01025b8:	e9 82 f9 ff ff       	jmp    c0101f3f <__alltraps>

c01025bd <vector169>:
.globl vector169
vector169:
  pushl $0
c01025bd:	6a 00                	push   $0x0
  pushl $169
c01025bf:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
c01025c4:	e9 76 f9 ff ff       	jmp    c0101f3f <__alltraps>

c01025c9 <vector170>:
.globl vector170
vector170:
  pushl $0
c01025c9:	6a 00                	push   $0x0
  pushl $170
c01025cb:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
c01025d0:	e9 6a f9 ff ff       	jmp    c0101f3f <__alltraps>

c01025d5 <vector171>:
.globl vector171
vector171:
  pushl $0
c01025d5:	6a 00                	push   $0x0
  pushl $171
c01025d7:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
c01025dc:	e9 5e f9 ff ff       	jmp    c0101f3f <__alltraps>

c01025e1 <vector172>:
.globl vector172
vector172:
  pushl $0
c01025e1:	6a 00                	push   $0x0
  pushl $172
c01025e3:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
c01025e8:	e9 52 f9 ff ff       	jmp    c0101f3f <__alltraps>

c01025ed <vector173>:
.globl vector173
vector173:
  pushl $0
c01025ed:	6a 00                	push   $0x0
  pushl $173
c01025ef:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
c01025f4:	e9 46 f9 ff ff       	jmp    c0101f3f <__alltraps>

c01025f9 <vector174>:
.globl vector174
vector174:
  pushl $0
c01025f9:	6a 00                	push   $0x0
  pushl $174
c01025fb:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
c0102600:	e9 3a f9 ff ff       	jmp    c0101f3f <__alltraps>

c0102605 <vector175>:
.globl vector175
vector175:
  pushl $0
c0102605:	6a 00                	push   $0x0
  pushl $175
c0102607:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
c010260c:	e9 2e f9 ff ff       	jmp    c0101f3f <__alltraps>

c0102611 <vector176>:
.globl vector176
vector176:
  pushl $0
c0102611:	6a 00                	push   $0x0
  pushl $176
c0102613:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
c0102618:	e9 22 f9 ff ff       	jmp    c0101f3f <__alltraps>

c010261d <vector177>:
.globl vector177
vector177:
  pushl $0
c010261d:	6a 00                	push   $0x0
  pushl $177
c010261f:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
c0102624:	e9 16 f9 ff ff       	jmp    c0101f3f <__alltraps>

c0102629 <vector178>:
.globl vector178
vector178:
  pushl $0
c0102629:	6a 00                	push   $0x0
  pushl $178
c010262b:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
c0102630:	e9 0a f9 ff ff       	jmp    c0101f3f <__alltraps>

c0102635 <vector179>:
.globl vector179
vector179:
  pushl $0
c0102635:	6a 00                	push   $0x0
  pushl $179
c0102637:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
c010263c:	e9 fe f8 ff ff       	jmp    c0101f3f <__alltraps>

c0102641 <vector180>:
.globl vector180
vector180:
  pushl $0
c0102641:	6a 00                	push   $0x0
  pushl $180
c0102643:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
c0102648:	e9 f2 f8 ff ff       	jmp    c0101f3f <__alltraps>

c010264d <vector181>:
.globl vector181
vector181:
  pushl $0
c010264d:	6a 00                	push   $0x0
  pushl $181
c010264f:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
c0102654:	e9 e6 f8 ff ff       	jmp    c0101f3f <__alltraps>

c0102659 <vector182>:
.globl vector182
vector182:
  pushl $0
c0102659:	6a 00                	push   $0x0
  pushl $182
c010265b:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
c0102660:	e9 da f8 ff ff       	jmp    c0101f3f <__alltraps>

c0102665 <vector183>:
.globl vector183
vector183:
  pushl $0
c0102665:	6a 00                	push   $0x0
  pushl $183
c0102667:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
c010266c:	e9 ce f8 ff ff       	jmp    c0101f3f <__alltraps>

c0102671 <vector184>:
.globl vector184
vector184:
  pushl $0
c0102671:	6a 00                	push   $0x0
  pushl $184
c0102673:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
c0102678:	e9 c2 f8 ff ff       	jmp    c0101f3f <__alltraps>

c010267d <vector185>:
.globl vector185
vector185:
  pushl $0
c010267d:	6a 00                	push   $0x0
  pushl $185
c010267f:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
c0102684:	e9 b6 f8 ff ff       	jmp    c0101f3f <__alltraps>

c0102689 <vector186>:
.globl vector186
vector186:
  pushl $0
c0102689:	6a 00                	push   $0x0
  pushl $186
c010268b:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
c0102690:	e9 aa f8 ff ff       	jmp    c0101f3f <__alltraps>

c0102695 <vector187>:
.globl vector187
vector187:
  pushl $0
c0102695:	6a 00                	push   $0x0
  pushl $187
c0102697:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
c010269c:	e9 9e f8 ff ff       	jmp    c0101f3f <__alltraps>

c01026a1 <vector188>:
.globl vector188
vector188:
  pushl $0
c01026a1:	6a 00                	push   $0x0
  pushl $188
c01026a3:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
c01026a8:	e9 92 f8 ff ff       	jmp    c0101f3f <__alltraps>

c01026ad <vector189>:
.globl vector189
vector189:
  pushl $0
c01026ad:	6a 00                	push   $0x0
  pushl $189
c01026af:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
c01026b4:	e9 86 f8 ff ff       	jmp    c0101f3f <__alltraps>

c01026b9 <vector190>:
.globl vector190
vector190:
  pushl $0
c01026b9:	6a 00                	push   $0x0
  pushl $190
c01026bb:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
c01026c0:	e9 7a f8 ff ff       	jmp    c0101f3f <__alltraps>

c01026c5 <vector191>:
.globl vector191
vector191:
  pushl $0
c01026c5:	6a 00                	push   $0x0
  pushl $191
c01026c7:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
c01026cc:	e9 6e f8 ff ff       	jmp    c0101f3f <__alltraps>

c01026d1 <vector192>:
.globl vector192
vector192:
  pushl $0
c01026d1:	6a 00                	push   $0x0
  pushl $192
c01026d3:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
c01026d8:	e9 62 f8 ff ff       	jmp    c0101f3f <__alltraps>

c01026dd <vector193>:
.globl vector193
vector193:
  pushl $0
c01026dd:	6a 00                	push   $0x0
  pushl $193
c01026df:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
c01026e4:	e9 56 f8 ff ff       	jmp    c0101f3f <__alltraps>

c01026e9 <vector194>:
.globl vector194
vector194:
  pushl $0
c01026e9:	6a 00                	push   $0x0
  pushl $194
c01026eb:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
c01026f0:	e9 4a f8 ff ff       	jmp    c0101f3f <__alltraps>

c01026f5 <vector195>:
.globl vector195
vector195:
  pushl $0
c01026f5:	6a 00                	push   $0x0
  pushl $195
c01026f7:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
c01026fc:	e9 3e f8 ff ff       	jmp    c0101f3f <__alltraps>

c0102701 <vector196>:
.globl vector196
vector196:
  pushl $0
c0102701:	6a 00                	push   $0x0
  pushl $196
c0102703:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
c0102708:	e9 32 f8 ff ff       	jmp    c0101f3f <__alltraps>

c010270d <vector197>:
.globl vector197
vector197:
  pushl $0
c010270d:	6a 00                	push   $0x0
  pushl $197
c010270f:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
c0102714:	e9 26 f8 ff ff       	jmp    c0101f3f <__alltraps>

c0102719 <vector198>:
.globl vector198
vector198:
  pushl $0
c0102719:	6a 00                	push   $0x0
  pushl $198
c010271b:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
c0102720:	e9 1a f8 ff ff       	jmp    c0101f3f <__alltraps>

c0102725 <vector199>:
.globl vector199
vector199:
  pushl $0
c0102725:	6a 00                	push   $0x0
  pushl $199
c0102727:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
c010272c:	e9 0e f8 ff ff       	jmp    c0101f3f <__alltraps>

c0102731 <vector200>:
.globl vector200
vector200:
  pushl $0
c0102731:	6a 00                	push   $0x0
  pushl $200
c0102733:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
c0102738:	e9 02 f8 ff ff       	jmp    c0101f3f <__alltraps>

c010273d <vector201>:
.globl vector201
vector201:
  pushl $0
c010273d:	6a 00                	push   $0x0
  pushl $201
c010273f:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
c0102744:	e9 f6 f7 ff ff       	jmp    c0101f3f <__alltraps>

c0102749 <vector202>:
.globl vector202
vector202:
  pushl $0
c0102749:	6a 00                	push   $0x0
  pushl $202
c010274b:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
c0102750:	e9 ea f7 ff ff       	jmp    c0101f3f <__alltraps>

c0102755 <vector203>:
.globl vector203
vector203:
  pushl $0
c0102755:	6a 00                	push   $0x0
  pushl $203
c0102757:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
c010275c:	e9 de f7 ff ff       	jmp    c0101f3f <__alltraps>

c0102761 <vector204>:
.globl vector204
vector204:
  pushl $0
c0102761:	6a 00                	push   $0x0
  pushl $204
c0102763:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
c0102768:	e9 d2 f7 ff ff       	jmp    c0101f3f <__alltraps>

c010276d <vector205>:
.globl vector205
vector205:
  pushl $0
c010276d:	6a 00                	push   $0x0
  pushl $205
c010276f:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
c0102774:	e9 c6 f7 ff ff       	jmp    c0101f3f <__alltraps>

c0102779 <vector206>:
.globl vector206
vector206:
  pushl $0
c0102779:	6a 00                	push   $0x0
  pushl $206
c010277b:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
c0102780:	e9 ba f7 ff ff       	jmp    c0101f3f <__alltraps>

c0102785 <vector207>:
.globl vector207
vector207:
  pushl $0
c0102785:	6a 00                	push   $0x0
  pushl $207
c0102787:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
c010278c:	e9 ae f7 ff ff       	jmp    c0101f3f <__alltraps>

c0102791 <vector208>:
.globl vector208
vector208:
  pushl $0
c0102791:	6a 00                	push   $0x0
  pushl $208
c0102793:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
c0102798:	e9 a2 f7 ff ff       	jmp    c0101f3f <__alltraps>

c010279d <vector209>:
.globl vector209
vector209:
  pushl $0
c010279d:	6a 00                	push   $0x0
  pushl $209
c010279f:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
c01027a4:	e9 96 f7 ff ff       	jmp    c0101f3f <__alltraps>

c01027a9 <vector210>:
.globl vector210
vector210:
  pushl $0
c01027a9:	6a 00                	push   $0x0
  pushl $210
c01027ab:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
c01027b0:	e9 8a f7 ff ff       	jmp    c0101f3f <__alltraps>

c01027b5 <vector211>:
.globl vector211
vector211:
  pushl $0
c01027b5:	6a 00                	push   $0x0
  pushl $211
c01027b7:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
c01027bc:	e9 7e f7 ff ff       	jmp    c0101f3f <__alltraps>

c01027c1 <vector212>:
.globl vector212
vector212:
  pushl $0
c01027c1:	6a 00                	push   $0x0
  pushl $212
c01027c3:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
c01027c8:	e9 72 f7 ff ff       	jmp    c0101f3f <__alltraps>

c01027cd <vector213>:
.globl vector213
vector213:
  pushl $0
c01027cd:	6a 00                	push   $0x0
  pushl $213
c01027cf:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
c01027d4:	e9 66 f7 ff ff       	jmp    c0101f3f <__alltraps>

c01027d9 <vector214>:
.globl vector214
vector214:
  pushl $0
c01027d9:	6a 00                	push   $0x0
  pushl $214
c01027db:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
c01027e0:	e9 5a f7 ff ff       	jmp    c0101f3f <__alltraps>

c01027e5 <vector215>:
.globl vector215
vector215:
  pushl $0
c01027e5:	6a 00                	push   $0x0
  pushl $215
c01027e7:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
c01027ec:	e9 4e f7 ff ff       	jmp    c0101f3f <__alltraps>

c01027f1 <vector216>:
.globl vector216
vector216:
  pushl $0
c01027f1:	6a 00                	push   $0x0
  pushl $216
c01027f3:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
c01027f8:	e9 42 f7 ff ff       	jmp    c0101f3f <__alltraps>

c01027fd <vector217>:
.globl vector217
vector217:
  pushl $0
c01027fd:	6a 00                	push   $0x0
  pushl $217
c01027ff:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
c0102804:	e9 36 f7 ff ff       	jmp    c0101f3f <__alltraps>

c0102809 <vector218>:
.globl vector218
vector218:
  pushl $0
c0102809:	6a 00                	push   $0x0
  pushl $218
c010280b:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
c0102810:	e9 2a f7 ff ff       	jmp    c0101f3f <__alltraps>

c0102815 <vector219>:
.globl vector219
vector219:
  pushl $0
c0102815:	6a 00                	push   $0x0
  pushl $219
c0102817:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
c010281c:	e9 1e f7 ff ff       	jmp    c0101f3f <__alltraps>

c0102821 <vector220>:
.globl vector220
vector220:
  pushl $0
c0102821:	6a 00                	push   $0x0
  pushl $220
c0102823:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
c0102828:	e9 12 f7 ff ff       	jmp    c0101f3f <__alltraps>

c010282d <vector221>:
.globl vector221
vector221:
  pushl $0
c010282d:	6a 00                	push   $0x0
  pushl $221
c010282f:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
c0102834:	e9 06 f7 ff ff       	jmp    c0101f3f <__alltraps>

c0102839 <vector222>:
.globl vector222
vector222:
  pushl $0
c0102839:	6a 00                	push   $0x0
  pushl $222
c010283b:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
c0102840:	e9 fa f6 ff ff       	jmp    c0101f3f <__alltraps>

c0102845 <vector223>:
.globl vector223
vector223:
  pushl $0
c0102845:	6a 00                	push   $0x0
  pushl $223
c0102847:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
c010284c:	e9 ee f6 ff ff       	jmp    c0101f3f <__alltraps>

c0102851 <vector224>:
.globl vector224
vector224:
  pushl $0
c0102851:	6a 00                	push   $0x0
  pushl $224
c0102853:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
c0102858:	e9 e2 f6 ff ff       	jmp    c0101f3f <__alltraps>

c010285d <vector225>:
.globl vector225
vector225:
  pushl $0
c010285d:	6a 00                	push   $0x0
  pushl $225
c010285f:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
c0102864:	e9 d6 f6 ff ff       	jmp    c0101f3f <__alltraps>

c0102869 <vector226>:
.globl vector226
vector226:
  pushl $0
c0102869:	6a 00                	push   $0x0
  pushl $226
c010286b:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
c0102870:	e9 ca f6 ff ff       	jmp    c0101f3f <__alltraps>

c0102875 <vector227>:
.globl vector227
vector227:
  pushl $0
c0102875:	6a 00                	push   $0x0
  pushl $227
c0102877:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
c010287c:	e9 be f6 ff ff       	jmp    c0101f3f <__alltraps>

c0102881 <vector228>:
.globl vector228
vector228:
  pushl $0
c0102881:	6a 00                	push   $0x0
  pushl $228
c0102883:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
c0102888:	e9 b2 f6 ff ff       	jmp    c0101f3f <__alltraps>

c010288d <vector229>:
.globl vector229
vector229:
  pushl $0
c010288d:	6a 00                	push   $0x0
  pushl $229
c010288f:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
c0102894:	e9 a6 f6 ff ff       	jmp    c0101f3f <__alltraps>

c0102899 <vector230>:
.globl vector230
vector230:
  pushl $0
c0102899:	6a 00                	push   $0x0
  pushl $230
c010289b:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
c01028a0:	e9 9a f6 ff ff       	jmp    c0101f3f <__alltraps>

c01028a5 <vector231>:
.globl vector231
vector231:
  pushl $0
c01028a5:	6a 00                	push   $0x0
  pushl $231
c01028a7:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
c01028ac:	e9 8e f6 ff ff       	jmp    c0101f3f <__alltraps>

c01028b1 <vector232>:
.globl vector232
vector232:
  pushl $0
c01028b1:	6a 00                	push   $0x0
  pushl $232
c01028b3:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
c01028b8:	e9 82 f6 ff ff       	jmp    c0101f3f <__alltraps>

c01028bd <vector233>:
.globl vector233
vector233:
  pushl $0
c01028bd:	6a 00                	push   $0x0
  pushl $233
c01028bf:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
c01028c4:	e9 76 f6 ff ff       	jmp    c0101f3f <__alltraps>

c01028c9 <vector234>:
.globl vector234
vector234:
  pushl $0
c01028c9:	6a 00                	push   $0x0
  pushl $234
c01028cb:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
c01028d0:	e9 6a f6 ff ff       	jmp    c0101f3f <__alltraps>

c01028d5 <vector235>:
.globl vector235
vector235:
  pushl $0
c01028d5:	6a 00                	push   $0x0
  pushl $235
c01028d7:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
c01028dc:	e9 5e f6 ff ff       	jmp    c0101f3f <__alltraps>

c01028e1 <vector236>:
.globl vector236
vector236:
  pushl $0
c01028e1:	6a 00                	push   $0x0
  pushl $236
c01028e3:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
c01028e8:	e9 52 f6 ff ff       	jmp    c0101f3f <__alltraps>

c01028ed <vector237>:
.globl vector237
vector237:
  pushl $0
c01028ed:	6a 00                	push   $0x0
  pushl $237
c01028ef:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
c01028f4:	e9 46 f6 ff ff       	jmp    c0101f3f <__alltraps>

c01028f9 <vector238>:
.globl vector238
vector238:
  pushl $0
c01028f9:	6a 00                	push   $0x0
  pushl $238
c01028fb:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
c0102900:	e9 3a f6 ff ff       	jmp    c0101f3f <__alltraps>

c0102905 <vector239>:
.globl vector239
vector239:
  pushl $0
c0102905:	6a 00                	push   $0x0
  pushl $239
c0102907:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
c010290c:	e9 2e f6 ff ff       	jmp    c0101f3f <__alltraps>

c0102911 <vector240>:
.globl vector240
vector240:
  pushl $0
c0102911:	6a 00                	push   $0x0
  pushl $240
c0102913:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
c0102918:	e9 22 f6 ff ff       	jmp    c0101f3f <__alltraps>

c010291d <vector241>:
.globl vector241
vector241:
  pushl $0
c010291d:	6a 00                	push   $0x0
  pushl $241
c010291f:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
c0102924:	e9 16 f6 ff ff       	jmp    c0101f3f <__alltraps>

c0102929 <vector242>:
.globl vector242
vector242:
  pushl $0
c0102929:	6a 00                	push   $0x0
  pushl $242
c010292b:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
c0102930:	e9 0a f6 ff ff       	jmp    c0101f3f <__alltraps>

c0102935 <vector243>:
.globl vector243
vector243:
  pushl $0
c0102935:	6a 00                	push   $0x0
  pushl $243
c0102937:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
c010293c:	e9 fe f5 ff ff       	jmp    c0101f3f <__alltraps>

c0102941 <vector244>:
.globl vector244
vector244:
  pushl $0
c0102941:	6a 00                	push   $0x0
  pushl $244
c0102943:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
c0102948:	e9 f2 f5 ff ff       	jmp    c0101f3f <__alltraps>

c010294d <vector245>:
.globl vector245
vector245:
  pushl $0
c010294d:	6a 00                	push   $0x0
  pushl $245
c010294f:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
c0102954:	e9 e6 f5 ff ff       	jmp    c0101f3f <__alltraps>

c0102959 <vector246>:
.globl vector246
vector246:
  pushl $0
c0102959:	6a 00                	push   $0x0
  pushl $246
c010295b:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
c0102960:	e9 da f5 ff ff       	jmp    c0101f3f <__alltraps>

c0102965 <vector247>:
.globl vector247
vector247:
  pushl $0
c0102965:	6a 00                	push   $0x0
  pushl $247
c0102967:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
c010296c:	e9 ce f5 ff ff       	jmp    c0101f3f <__alltraps>

c0102971 <vector248>:
.globl vector248
vector248:
  pushl $0
c0102971:	6a 00                	push   $0x0
  pushl $248
c0102973:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
c0102978:	e9 c2 f5 ff ff       	jmp    c0101f3f <__alltraps>

c010297d <vector249>:
.globl vector249
vector249:
  pushl $0
c010297d:	6a 00                	push   $0x0
  pushl $249
c010297f:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
c0102984:	e9 b6 f5 ff ff       	jmp    c0101f3f <__alltraps>

c0102989 <vector250>:
.globl vector250
vector250:
  pushl $0
c0102989:	6a 00                	push   $0x0
  pushl $250
c010298b:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
c0102990:	e9 aa f5 ff ff       	jmp    c0101f3f <__alltraps>

c0102995 <vector251>:
.globl vector251
vector251:
  pushl $0
c0102995:	6a 00                	push   $0x0
  pushl $251
c0102997:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
c010299c:	e9 9e f5 ff ff       	jmp    c0101f3f <__alltraps>

c01029a1 <vector252>:
.globl vector252
vector252:
  pushl $0
c01029a1:	6a 00                	push   $0x0
  pushl $252
c01029a3:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
c01029a8:	e9 92 f5 ff ff       	jmp    c0101f3f <__alltraps>

c01029ad <vector253>:
.globl vector253
vector253:
  pushl $0
c01029ad:	6a 00                	push   $0x0
  pushl $253
c01029af:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
c01029b4:	e9 86 f5 ff ff       	jmp    c0101f3f <__alltraps>

c01029b9 <vector254>:
.globl vector254
vector254:
  pushl $0
c01029b9:	6a 00                	push   $0x0
  pushl $254
c01029bb:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
c01029c0:	e9 7a f5 ff ff       	jmp    c0101f3f <__alltraps>

c01029c5 <vector255>:
.globl vector255
vector255:
  pushl $0
c01029c5:	6a 00                	push   $0x0
  pushl $255
c01029c7:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
c01029cc:	e9 6e f5 ff ff       	jmp    c0101f3f <__alltraps>

c01029d1 <page2ppn>:

extern struct Page *pages;
extern size_t npage;

static inline ppn_t
page2ppn(struct Page *page) {
c01029d1:	55                   	push   %ebp
c01029d2:	89 e5                	mov    %esp,%ebp
    return page - pages;
c01029d4:	8b 55 08             	mov    0x8(%ebp),%edx
c01029d7:	a1 c4 89 11 c0       	mov    0xc01189c4,%eax
c01029dc:	29 c2                	sub    %eax,%edx
c01029de:	89 d0                	mov    %edx,%eax
c01029e0:	c1 f8 02             	sar    $0x2,%eax
c01029e3:	69 c0 cd cc cc cc    	imul   $0xcccccccd,%eax,%eax
}
c01029e9:	5d                   	pop    %ebp
c01029ea:	c3                   	ret    

c01029eb <page2pa>:

static inline uintptr_t
page2pa(struct Page *page) {
c01029eb:	55                   	push   %ebp
c01029ec:	89 e5                	mov    %esp,%ebp
c01029ee:	83 ec 04             	sub    $0x4,%esp
    return page2ppn(page) << PGSHIFT;
c01029f1:	8b 45 08             	mov    0x8(%ebp),%eax
c01029f4:	89 04 24             	mov    %eax,(%esp)
c01029f7:	e8 d5 ff ff ff       	call   c01029d1 <page2ppn>
c01029fc:	c1 e0 0c             	shl    $0xc,%eax
}
c01029ff:	c9                   	leave  
c0102a00:	c3                   	ret    

c0102a01 <page_ref>:
pde2page(pde_t pde) {
    return pa2page(PDE_ADDR(pde));
}

static inline int
page_ref(struct Page *page) {
c0102a01:	55                   	push   %ebp
c0102a02:	89 e5                	mov    %esp,%ebp
    return page->ref;
c0102a04:	8b 45 08             	mov    0x8(%ebp),%eax
c0102a07:	8b 00                	mov    (%eax),%eax
}
c0102a09:	5d                   	pop    %ebp
c0102a0a:	c3                   	ret    

c0102a0b <set_page_ref>:

static inline void
set_page_ref(struct Page *page, int val) {
c0102a0b:	55                   	push   %ebp
c0102a0c:	89 e5                	mov    %esp,%ebp
    page->ref = val;
c0102a0e:	8b 45 08             	mov    0x8(%ebp),%eax
c0102a11:	8b 55 0c             	mov    0xc(%ebp),%edx
c0102a14:	89 10                	mov    %edx,(%eax)
}
c0102a16:	5d                   	pop    %ebp
c0102a17:	c3                   	ret    

c0102a18 <default_init>:

#define free_list (free_area.free_list)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
c0102a18:	55                   	push   %ebp
c0102a19:	89 e5                	mov    %esp,%ebp
c0102a1b:	83 ec 10             	sub    $0x10,%esp
c0102a1e:	c7 45 fc b0 89 11 c0 	movl   $0xc01189b0,-0x4(%ebp)
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
c0102a25:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0102a28:	8b 55 fc             	mov    -0x4(%ebp),%edx
c0102a2b:	89 50 04             	mov    %edx,0x4(%eax)
c0102a2e:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0102a31:	8b 50 04             	mov    0x4(%eax),%edx
c0102a34:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0102a37:	89 10                	mov    %edx,(%eax)
    list_init(&free_list);
    nr_free = 0;
c0102a39:	c7 05 b8 89 11 c0 00 	movl   $0x0,0xc01189b8
c0102a40:	00 00 00 
}
c0102a43:	c9                   	leave  
c0102a44:	c3                   	ret    

c0102a45 <default_init_memmap>:

static void
default_free_pages(struct Page *base, size_t n);

static void
default_init_memmap(struct Page *base, size_t n) {
c0102a45:	55                   	push   %ebp
c0102a46:	89 e5                	mov    %esp,%ebp
c0102a48:	83 ec 28             	sub    $0x28,%esp
    assert(n > 0);
c0102a4b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c0102a4f:	75 24                	jne    c0102a75 <default_init_memmap+0x30>
c0102a51:	c7 44 24 0c 10 68 10 	movl   $0xc0106810,0xc(%esp)
c0102a58:	c0 
c0102a59:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0102a60:	c0 
c0102a61:	c7 44 24 04 49 00 00 	movl   $0x49,0x4(%esp)
c0102a68:	00 
c0102a69:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0102a70:	e8 9f e2 ff ff       	call   c0100d14 <__panic>
    struct Page *p = base;
c0102a75:	8b 45 08             	mov    0x8(%ebp),%eax
c0102a78:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (; p != base + n; p ++) {
c0102a7b:	eb 7d                	jmp    c0102afa <default_init_memmap+0xb5>
        assert(PageReserved(p));
c0102a7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102a80:	83 c0 04             	add    $0x4,%eax
c0102a83:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
c0102a8a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0102a8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0102a90:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0102a93:	0f a3 10             	bt     %edx,(%eax)
c0102a96:	19 c0                	sbb    %eax,%eax
c0102a98:	89 45 e8             	mov    %eax,-0x18(%ebp)
    return oldbit != 0;
c0102a9b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0102a9f:	0f 95 c0             	setne  %al
c0102aa2:	0f b6 c0             	movzbl %al,%eax
c0102aa5:	85 c0                	test   %eax,%eax
c0102aa7:	75 24                	jne    c0102acd <default_init_memmap+0x88>
c0102aa9:	c7 44 24 0c 41 68 10 	movl   $0xc0106841,0xc(%esp)
c0102ab0:	c0 
c0102ab1:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0102ab8:	c0 
c0102ab9:	c7 44 24 04 4c 00 00 	movl   $0x4c,0x4(%esp)
c0102ac0:	00 
c0102ac1:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0102ac8:	e8 47 e2 ff ff       	call   c0100d14 <__panic>
        p->flags = p->property = 0;
c0102acd:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102ad0:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
c0102ad7:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102ada:	8b 50 08             	mov    0x8(%eax),%edx
c0102add:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102ae0:	89 50 04             	mov    %edx,0x4(%eax)
        set_page_ref(p, 0);
c0102ae3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c0102aea:	00 
c0102aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102aee:	89 04 24             	mov    %eax,(%esp)
c0102af1:	e8 15 ff ff ff       	call   c0102a0b <set_page_ref>

static void
default_init_memmap(struct Page *base, size_t n) {
    assert(n > 0);
    struct Page *p = base;
    for (; p != base + n; p ++) {
c0102af6:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
c0102afa:	8b 55 0c             	mov    0xc(%ebp),%edx
c0102afd:	89 d0                	mov    %edx,%eax
c0102aff:	c1 e0 02             	shl    $0x2,%eax
c0102b02:	01 d0                	add    %edx,%eax
c0102b04:	c1 e0 02             	shl    $0x2,%eax
c0102b07:	89 c2                	mov    %eax,%edx
c0102b09:	8b 45 08             	mov    0x8(%ebp),%eax
c0102b0c:	01 d0                	add    %edx,%eax
c0102b0e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c0102b11:	0f 85 66 ff ff ff    	jne    c0102a7d <default_init_memmap+0x38>
        assert(PageReserved(p));
        p->flags = p->property = 0;
        set_page_ref(p, 0);
    }

    default_free_pages(base, n);
c0102b17:	8b 45 0c             	mov    0xc(%ebp),%eax
c0102b1a:	89 44 24 04          	mov    %eax,0x4(%esp)
c0102b1e:	8b 45 08             	mov    0x8(%ebp),%eax
c0102b21:	89 04 24             	mov    %eax,(%esp)
c0102b24:	e8 c5 01 00 00       	call   c0102cee <default_free_pages>
}
c0102b29:	c9                   	leave  
c0102b2a:	c3                   	ret    

c0102b2b <default_alloc_pages>:

static struct Page *
default_alloc_pages(size_t n) {
c0102b2b:	55                   	push   %ebp
c0102b2c:	89 e5                	mov    %esp,%ebp
c0102b2e:	83 ec 68             	sub    $0x68,%esp
    assert(n > 0);
c0102b31:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0102b35:	75 24                	jne    c0102b5b <default_alloc_pages+0x30>
c0102b37:	c7 44 24 0c 10 68 10 	movl   $0xc0106810,0xc(%esp)
c0102b3e:	c0 
c0102b3f:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0102b46:	c0 
c0102b47:	c7 44 24 04 56 00 00 	movl   $0x56,0x4(%esp)
c0102b4e:	00 
c0102b4f:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0102b56:	e8 b9 e1 ff ff       	call   c0100d14 <__panic>
    if (n > nr_free) {
c0102b5b:	a1 b8 89 11 c0       	mov    0xc01189b8,%eax
c0102b60:	3b 45 08             	cmp    0x8(%ebp),%eax
c0102b63:	73 0a                	jae    c0102b6f <default_alloc_pages+0x44>
        return NULL;
c0102b65:	b8 00 00 00 00       	mov    $0x0,%eax
c0102b6a:	e9 7d 01 00 00       	jmp    c0102cec <default_alloc_pages+0x1c1>
    }

    //find the first fit block('page')
    struct Page *page = NULL;
c0102b6f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    list_entry_t *le = &free_list;
c0102b76:	c7 45 f0 b0 89 11 c0 	movl   $0xc01189b0,-0x10(%ebp)
    while ((le = list_next(le)) != &free_list) {
c0102b7d:	eb 1c                	jmp    c0102b9b <default_alloc_pages+0x70>
        struct Page *p = le2page(le, page_link);
c0102b7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0102b82:	83 e8 0c             	sub    $0xc,%eax
c0102b85:	89 45 ec             	mov    %eax,-0x14(%ebp)
        if (p->property >= n) {
c0102b88:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0102b8b:	8b 40 08             	mov    0x8(%eax),%eax
c0102b8e:	3b 45 08             	cmp    0x8(%ebp),%eax
c0102b91:	72 08                	jb     c0102b9b <default_alloc_pages+0x70>
            page = p;
c0102b93:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0102b96:	89 45 f4             	mov    %eax,-0xc(%ebp)
            break;
c0102b99:	eb 18                	jmp    c0102bb3 <default_alloc_pages+0x88>
c0102b9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0102b9e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
c0102ba1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0102ba4:	8b 40 04             	mov    0x4(%eax),%eax
    }

    //find the first fit block('page')
    struct Page *page = NULL;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
c0102ba7:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0102baa:	81 7d f0 b0 89 11 c0 	cmpl   $0xc01189b0,-0x10(%ebp)
c0102bb1:	75 cc                	jne    c0102b7f <default_alloc_pages+0x54>
            page = p;
            break;
        }
    }

    if (page != NULL)
c0102bb3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0102bb7:	0f 84 2c 01 00 00    	je     c0102ce9 <default_alloc_pages+0x1be>
    {
    	if (page->property == n) //if it fits exactly, then alloc.
c0102bbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102bc0:	8b 40 08             	mov    0x8(%eax),%eax
c0102bc3:	3b 45 08             	cmp    0x8(%ebp),%eax
c0102bc6:	75 30                	jne    c0102bf8 <default_alloc_pages+0xcd>
    		list_del(&(page->page_link));
c0102bc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102bcb:	83 c0 0c             	add    $0xc,%eax
c0102bce:	89 45 e0             	mov    %eax,-0x20(%ebp)
 * Note: list_empty() on @listelm does not return true after this, the entry is
 * in an undefined state.
 * */
static inline void
list_del(list_entry_t *listelm) {
    __list_del(listelm->prev, listelm->next);
c0102bd1:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0102bd4:	8b 40 04             	mov    0x4(%eax),%eax
c0102bd7:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0102bda:	8b 12                	mov    (%edx),%edx
c0102bdc:	89 55 dc             	mov    %edx,-0x24(%ebp)
c0102bdf:	89 45 d8             	mov    %eax,-0x28(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
c0102be2:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0102be5:	8b 55 d8             	mov    -0x28(%ebp),%edx
c0102be8:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
c0102beb:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0102bee:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102bf1:	89 10                	mov    %edx,(%eax)
c0102bf3:	e9 c2 00 00 00       	jmp    c0102cba <default_alloc_pages+0x18f>
    	else if (page->property > n) //if it's too large, split it.
c0102bf8:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102bfb:	8b 40 08             	mov    0x8(%eax),%eax
c0102bfe:	3b 45 08             	cmp    0x8(%ebp),%eax
c0102c01:	0f 86 b3 00 00 00    	jbe    c0102cba <default_alloc_pages+0x18f>
    	{
            struct Page *p = page + n;
c0102c07:	8b 55 08             	mov    0x8(%ebp),%edx
c0102c0a:	89 d0                	mov    %edx,%eax
c0102c0c:	c1 e0 02             	shl    $0x2,%eax
c0102c0f:	01 d0                	add    %edx,%eax
c0102c11:	c1 e0 02             	shl    $0x2,%eax
c0102c14:	89 c2                	mov    %eax,%edx
c0102c16:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102c19:	01 d0                	add    %edx,%eax
c0102c1b:	89 45 e8             	mov    %eax,-0x18(%ebp)
            p->property = page->property - n;
c0102c1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102c21:	8b 40 08             	mov    0x8(%eax),%eax
c0102c24:	2b 45 08             	sub    0x8(%ebp),%eax
c0102c27:	89 c2                	mov    %eax,%edx
c0102c29:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0102c2c:	89 50 08             	mov    %edx,0x8(%eax)
            SetPageProperty(p);
c0102c2f:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0102c32:	83 c0 04             	add    $0x4,%eax
c0102c35:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
c0102c3c:	89 45 d0             	mov    %eax,-0x30(%ebp)
 * Note that @nr may be almost arbitrarily large; this function is not
 * restricted to acting on a single-word quantity.
 * */
static inline void
set_bit(int nr, volatile void *addr) {
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c0102c3f:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0102c42:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0102c45:	0f ab 10             	bts    %edx,(%eax)
            list_add_before(le, &(p->page_link));
c0102c48:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0102c4b:	8d 50 0c             	lea    0xc(%eax),%edx
c0102c4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0102c51:	89 45 cc             	mov    %eax,-0x34(%ebp)
c0102c54:	89 55 c8             	mov    %edx,-0x38(%ebp)
 * Insert the new element @elm *before* the element @listelm which
 * is already in the list.
 * */
static inline void
list_add_before(list_entry_t *listelm, list_entry_t *elm) {
    __list_add(elm, listelm->prev, listelm);
c0102c57:	8b 45 cc             	mov    -0x34(%ebp),%eax
c0102c5a:	8b 00                	mov    (%eax),%eax
c0102c5c:	8b 55 c8             	mov    -0x38(%ebp),%edx
c0102c5f:	89 55 c4             	mov    %edx,-0x3c(%ebp)
c0102c62:	89 45 c0             	mov    %eax,-0x40(%ebp)
c0102c65:	8b 45 cc             	mov    -0x34(%ebp),%eax
c0102c68:	89 45 bc             	mov    %eax,-0x44(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
c0102c6b:	8b 45 bc             	mov    -0x44(%ebp),%eax
c0102c6e:	8b 55 c4             	mov    -0x3c(%ebp),%edx
c0102c71:	89 10                	mov    %edx,(%eax)
c0102c73:	8b 45 bc             	mov    -0x44(%ebp),%eax
c0102c76:	8b 10                	mov    (%eax),%edx
c0102c78:	8b 45 c0             	mov    -0x40(%ebp),%eax
c0102c7b:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
c0102c7e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c0102c81:	8b 55 bc             	mov    -0x44(%ebp),%edx
c0102c84:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
c0102c87:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c0102c8a:	8b 55 c0             	mov    -0x40(%ebp),%edx
c0102c8d:	89 10                	mov    %edx,(%eax)
            list_del(&(page->page_link));
c0102c8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102c92:	83 c0 0c             	add    $0xc,%eax
c0102c95:	89 45 b8             	mov    %eax,-0x48(%ebp)
 * Note: list_empty() on @listelm does not return true after this, the entry is
 * in an undefined state.
 * */
static inline void
list_del(list_entry_t *listelm) {
    __list_del(listelm->prev, listelm->next);
c0102c98:	8b 45 b8             	mov    -0x48(%ebp),%eax
c0102c9b:	8b 40 04             	mov    0x4(%eax),%eax
c0102c9e:	8b 55 b8             	mov    -0x48(%ebp),%edx
c0102ca1:	8b 12                	mov    (%edx),%edx
c0102ca3:	89 55 b4             	mov    %edx,-0x4c(%ebp)
c0102ca6:	89 45 b0             	mov    %eax,-0x50(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
c0102ca9:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0102cac:	8b 55 b0             	mov    -0x50(%ebp),%edx
c0102caf:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
c0102cb2:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0102cb5:	8b 55 b4             	mov    -0x4c(%ebp),%edx
c0102cb8:	89 10                	mov    %edx,(%eax)
    	}

    	//allocate
    	page->property= n;
c0102cba:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102cbd:	8b 55 08             	mov    0x8(%ebp),%edx
c0102cc0:	89 50 08             	mov    %edx,0x8(%eax)
        nr_free -= n;
c0102cc3:	a1 b8 89 11 c0       	mov    0xc01189b8,%eax
c0102cc8:	2b 45 08             	sub    0x8(%ebp),%eax
c0102ccb:	a3 b8 89 11 c0       	mov    %eax,0xc01189b8
        ClearPageProperty(page);
c0102cd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102cd3:	83 c0 04             	add    $0x4,%eax
c0102cd6:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
c0102cdd:	89 45 a8             	mov    %eax,-0x58(%ebp)
 * @nr:     the bit to clear
 * @addr:   the address to start counting from
 * */
static inline void
clear_bit(int nr, volatile void *addr) {
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c0102ce0:	8b 45 a8             	mov    -0x58(%ebp),%eax
c0102ce3:	8b 55 ac             	mov    -0x54(%ebp),%edx
c0102ce6:	0f b3 10             	btr    %edx,(%eax)
    }
    return page;
c0102ce9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0102cec:	c9                   	leave  
c0102ced:	c3                   	ret    

c0102cee <default_free_pages>:

static void
default_free_pages(struct Page *base, size_t n) {
c0102cee:	55                   	push   %ebp
c0102cef:	89 e5                	mov    %esp,%ebp
c0102cf1:	83 ec 78             	sub    $0x78,%esp
    assert(n > 0);
c0102cf4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c0102cf8:	75 24                	jne    c0102d1e <default_free_pages+0x30>
c0102cfa:	c7 44 24 0c 10 68 10 	movl   $0xc0106810,0xc(%esp)
c0102d01:	c0 
c0102d02:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0102d09:	c0 
c0102d0a:	c7 44 24 04 7d 00 00 	movl   $0x7d,0x4(%esp)
c0102d11:	00 
c0102d12:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0102d19:	e8 f6 df ff ff       	call   c0100d14 <__panic>

    struct Page *p = base;
c0102d1e:	8b 45 08             	mov    0x8(%ebp),%eax
c0102d21:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (; p != base + n; p ++) {
c0102d24:	eb 21                	jmp    c0102d47 <default_free_pages+0x59>
        p->flags = 0;
c0102d26:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102d29:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
        set_page_ref(p, 0);
c0102d30:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c0102d37:	00 
c0102d38:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102d3b:	89 04 24             	mov    %eax,(%esp)
c0102d3e:	e8 c8 fc ff ff       	call   c0102a0b <set_page_ref>
static void
default_free_pages(struct Page *base, size_t n) {
    assert(n > 0);

    struct Page *p = base;
    for (; p != base + n; p ++) {
c0102d43:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
c0102d47:	8b 55 0c             	mov    0xc(%ebp),%edx
c0102d4a:	89 d0                	mov    %edx,%eax
c0102d4c:	c1 e0 02             	shl    $0x2,%eax
c0102d4f:	01 d0                	add    %edx,%eax
c0102d51:	c1 e0 02             	shl    $0x2,%eax
c0102d54:	89 c2                	mov    %eax,%edx
c0102d56:	8b 45 08             	mov    0x8(%ebp),%eax
c0102d59:	01 d0                	add    %edx,%eax
c0102d5b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c0102d5e:	75 c6                	jne    c0102d26 <default_free_pages+0x38>
        p->flags = 0;
        set_page_ref(p, 0);
    }

    base->property= n;
c0102d60:	8b 45 08             	mov    0x8(%ebp),%eax
c0102d63:	8b 55 0c             	mov    0xc(%ebp),%edx
c0102d66:	89 50 08             	mov    %edx,0x8(%eax)
    SetPageProperty(base);
c0102d69:	8b 45 08             	mov    0x8(%ebp),%eax
c0102d6c:	83 c0 04             	add    $0x4,%eax
c0102d6f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
c0102d76:	89 45 e8             	mov    %eax,-0x18(%ebp)
 * Note that @nr may be almost arbitrarily large; this function is not
 * restricted to acting on a single-word quantity.
 * */
static inline void
set_bit(int nr, volatile void *addr) {
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c0102d79:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0102d7c:	8b 55 ec             	mov    -0x14(%ebp),%edx
c0102d7f:	0f ab 10             	bts    %edx,(%eax)
c0102d82:	c7 45 e4 b0 89 11 c0 	movl   $0xc01189b0,-0x1c(%ebp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
c0102d89:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0102d8c:	8b 40 04             	mov    0x4(%eax),%eax

    //find the block who should exactly follow the new free one in free list(sorted by address)
    list_entry_t *le = list_next(&free_list);
c0102d8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (le != &free_list)
c0102d92:	eb 22                	jmp    c0102db6 <default_free_pages+0xc8>
    {
    	p = le2page(le, page_link);
c0102d94:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0102d97:	83 e8 0c             	sub    $0xc,%eax
c0102d9a:	89 45 f4             	mov    %eax,-0xc(%ebp)

    	if (p > base)
c0102d9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102da0:	3b 45 08             	cmp    0x8(%ebp),%eax
c0102da3:	76 02                	jbe    c0102da7 <default_free_pages+0xb9>
    		break ;
c0102da5:	eb 18                	jmp    c0102dbf <default_free_pages+0xd1>
c0102da7:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0102daa:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0102dad:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0102db0:	8b 40 04             	mov    0x4(%eax),%eax

    	le = list_next(le);
c0102db3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    base->property= n;
    SetPageProperty(base);

    //find the block who should exactly follow the new free one in free list(sorted by address)
    list_entry_t *le = list_next(&free_list);
    while (le != &free_list)
c0102db6:	81 7d f0 b0 89 11 c0 	cmpl   $0xc01189b0,-0x10(%ebp)
c0102dbd:	75 d5                	jne    c0102d94 <default_free_pages+0xa6>

    	le = list_next(le);
    }

    //insert the new free block
    p = le2page(le, page_link);
c0102dbf:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0102dc2:	83 e8 0c             	sub    $0xc,%eax
c0102dc5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	list_add_before(le, &(base->page_link));
c0102dc8:	8b 45 08             	mov    0x8(%ebp),%eax
c0102dcb:	8d 50 0c             	lea    0xc(%eax),%edx
c0102dce:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0102dd1:	89 45 dc             	mov    %eax,-0x24(%ebp)
c0102dd4:	89 55 d8             	mov    %edx,-0x28(%ebp)
 * Insert the new element @elm *before* the element @listelm which
 * is already in the list.
 * */
static inline void
list_add_before(list_entry_t *listelm, list_entry_t *elm) {
    __list_add(elm, listelm->prev, listelm);
c0102dd7:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0102dda:	8b 00                	mov    (%eax),%eax
c0102ddc:	8b 55 d8             	mov    -0x28(%ebp),%edx
c0102ddf:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c0102de2:	89 45 d0             	mov    %eax,-0x30(%ebp)
c0102de5:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0102de8:	89 45 cc             	mov    %eax,-0x34(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
c0102deb:	8b 45 cc             	mov    -0x34(%ebp),%eax
c0102dee:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0102df1:	89 10                	mov    %edx,(%eax)
c0102df3:	8b 45 cc             	mov    -0x34(%ebp),%eax
c0102df6:	8b 10                	mov    (%eax),%edx
c0102df8:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0102dfb:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
c0102dfe:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0102e01:	8b 55 cc             	mov    -0x34(%ebp),%edx
c0102e04:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
c0102e07:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0102e0a:	8b 55 d0             	mov    -0x30(%ebp),%edx
c0102e0d:	89 10                	mov    %edx,(%eax)

	//merged with the follow one if possible
	if (base + base->property == p) {
c0102e0f:	8b 45 08             	mov    0x8(%ebp),%eax
c0102e12:	8b 50 08             	mov    0x8(%eax),%edx
c0102e15:	89 d0                	mov    %edx,%eax
c0102e17:	c1 e0 02             	shl    $0x2,%eax
c0102e1a:	01 d0                	add    %edx,%eax
c0102e1c:	c1 e0 02             	shl    $0x2,%eax
c0102e1f:	89 c2                	mov    %eax,%edx
c0102e21:	8b 45 08             	mov    0x8(%ebp),%eax
c0102e24:	01 d0                	add    %edx,%eax
c0102e26:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c0102e29:	75 58                	jne    c0102e83 <default_free_pages+0x195>
		base->property += p->property;
c0102e2b:	8b 45 08             	mov    0x8(%ebp),%eax
c0102e2e:	8b 50 08             	mov    0x8(%eax),%edx
c0102e31:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102e34:	8b 40 08             	mov    0x8(%eax),%eax
c0102e37:	01 c2                	add    %eax,%edx
c0102e39:	8b 45 08             	mov    0x8(%ebp),%eax
c0102e3c:	89 50 08             	mov    %edx,0x8(%eax)
		ClearPageProperty(p);
c0102e3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102e42:	83 c0 04             	add    $0x4,%eax
c0102e45:	c7 45 c8 01 00 00 00 	movl   $0x1,-0x38(%ebp)
c0102e4c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 * @nr:     the bit to clear
 * @addr:   the address to start counting from
 * */
static inline void
clear_bit(int nr, volatile void *addr) {
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c0102e4f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c0102e52:	8b 55 c8             	mov    -0x38(%ebp),%edx
c0102e55:	0f b3 10             	btr    %edx,(%eax)
		list_del(&(p->page_link));
c0102e58:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102e5b:	83 c0 0c             	add    $0xc,%eax
c0102e5e:	89 45 c0             	mov    %eax,-0x40(%ebp)
 * Note: list_empty() on @listelm does not return true after this, the entry is
 * in an undefined state.
 * */
static inline void
list_del(list_entry_t *listelm) {
    __list_del(listelm->prev, listelm->next);
c0102e61:	8b 45 c0             	mov    -0x40(%ebp),%eax
c0102e64:	8b 40 04             	mov    0x4(%eax),%eax
c0102e67:	8b 55 c0             	mov    -0x40(%ebp),%edx
c0102e6a:	8b 12                	mov    (%edx),%edx
c0102e6c:	89 55 bc             	mov    %edx,-0x44(%ebp)
c0102e6f:	89 45 b8             	mov    %eax,-0x48(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
c0102e72:	8b 45 bc             	mov    -0x44(%ebp),%eax
c0102e75:	8b 55 b8             	mov    -0x48(%ebp),%edx
c0102e78:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
c0102e7b:	8b 45 b8             	mov    -0x48(%ebp),%eax
c0102e7e:	8b 55 bc             	mov    -0x44(%ebp),%edx
c0102e81:	89 10                	mov    %edx,(%eax)
	}

	//merged with the ahead one if possible
	le = list_prev(&(base->page_link));
c0102e83:	8b 45 08             	mov    0x8(%ebp),%eax
c0102e86:	83 c0 0c             	add    $0xc,%eax
c0102e89:	89 45 b4             	mov    %eax,-0x4c(%ebp)
 * list_prev - get the previous entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_prev(list_entry_t *listelm) {
    return listelm->prev;
c0102e8c:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0102e8f:	8b 00                	mov    (%eax),%eax
c0102e91:	89 45 f0             	mov    %eax,-0x10(%ebp)
	p = le2page(le, page_link);
c0102e94:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0102e97:	83 e8 0c             	sub    $0xc,%eax
c0102e9a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	if (p + p->property == base) {
c0102e9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102ea0:	8b 50 08             	mov    0x8(%eax),%edx
c0102ea3:	89 d0                	mov    %edx,%eax
c0102ea5:	c1 e0 02             	shl    $0x2,%eax
c0102ea8:	01 d0                	add    %edx,%eax
c0102eaa:	c1 e0 02             	shl    $0x2,%eax
c0102ead:	89 c2                	mov    %eax,%edx
c0102eaf:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102eb2:	01 d0                	add    %edx,%eax
c0102eb4:	3b 45 08             	cmp    0x8(%ebp),%eax
c0102eb7:	75 5e                	jne    c0102f17 <default_free_pages+0x229>
		p->property += base->property;
c0102eb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102ebc:	8b 50 08             	mov    0x8(%eax),%edx
c0102ebf:	8b 45 08             	mov    0x8(%ebp),%eax
c0102ec2:	8b 40 08             	mov    0x8(%eax),%eax
c0102ec5:	01 c2                	add    %eax,%edx
c0102ec7:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102eca:	89 50 08             	mov    %edx,0x8(%eax)

		ClearPageProperty(base);
c0102ecd:	8b 45 08             	mov    0x8(%ebp),%eax
c0102ed0:	83 c0 04             	add    $0x4,%eax
c0102ed3:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
c0102eda:	89 45 ac             	mov    %eax,-0x54(%ebp)
c0102edd:	8b 45 ac             	mov    -0x54(%ebp),%eax
c0102ee0:	8b 55 b0             	mov    -0x50(%ebp),%edx
c0102ee3:	0f b3 10             	btr    %edx,(%eax)
		list_del(&(base->page_link));
c0102ee6:	8b 45 08             	mov    0x8(%ebp),%eax
c0102ee9:	83 c0 0c             	add    $0xc,%eax
c0102eec:	89 45 a8             	mov    %eax,-0x58(%ebp)
 * Note: list_empty() on @listelm does not return true after this, the entry is
 * in an undefined state.
 * */
static inline void
list_del(list_entry_t *listelm) {
    __list_del(listelm->prev, listelm->next);
c0102eef:	8b 45 a8             	mov    -0x58(%ebp),%eax
c0102ef2:	8b 40 04             	mov    0x4(%eax),%eax
c0102ef5:	8b 55 a8             	mov    -0x58(%ebp),%edx
c0102ef8:	8b 12                	mov    (%edx),%edx
c0102efa:	89 55 a4             	mov    %edx,-0x5c(%ebp)
c0102efd:	89 45 a0             	mov    %eax,-0x60(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
c0102f00:	8b 45 a4             	mov    -0x5c(%ebp),%eax
c0102f03:	8b 55 a0             	mov    -0x60(%ebp),%edx
c0102f06:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
c0102f09:	8b 45 a0             	mov    -0x60(%ebp),%eax
c0102f0c:	8b 55 a4             	mov    -0x5c(%ebp),%edx
c0102f0f:	89 10                	mov    %edx,(%eax)
		base = p;
c0102f11:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102f14:	89 45 08             	mov    %eax,0x8(%ebp)
	}

	nr_free += n;
c0102f17:	8b 15 b8 89 11 c0    	mov    0xc01189b8,%edx
c0102f1d:	8b 45 0c             	mov    0xc(%ebp),%eax
c0102f20:	01 d0                	add    %edx,%eax
c0102f22:	a3 b8 89 11 c0       	mov    %eax,0xc01189b8
	return ;
c0102f27:	90                   	nop
}
c0102f28:	c9                   	leave  
c0102f29:	c3                   	ret    

c0102f2a <print_free_list>:

//print free list, used for debug
static void print_free_list()
{
c0102f2a:	55                   	push   %ebp
c0102f2b:	89 e5                	mov    %esp,%ebp
c0102f2d:	83 ec 28             	sub    $0x28,%esp
c0102f30:	c7 45 ec b0 89 11 c0 	movl   $0xc01189b0,-0x14(%ebp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
c0102f37:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0102f3a:	8b 40 04             	mov    0x4(%eax),%eax
	list_entry_t *le = list_next(&free_list);
c0102f3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct Page *p;
	while (le != &free_list)
c0102f40:	eb 35                	jmp    c0102f77 <print_free_list+0x4d>
	{
		p = le2page(le, page_link);
c0102f42:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102f45:	83 e8 0c             	sub    $0xc,%eax
c0102f48:	89 45 f0             	mov    %eax,-0x10(%ebp)

		cprintf("	%08x %d\n", p, p->property);
c0102f4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0102f4e:	8b 40 08             	mov    0x8(%eax),%eax
c0102f51:	89 44 24 08          	mov    %eax,0x8(%esp)
c0102f55:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0102f58:	89 44 24 04          	mov    %eax,0x4(%esp)
c0102f5c:	c7 04 24 51 68 10 c0 	movl   $0xc0106851,(%esp)
c0102f63:	e8 e4 d3 ff ff       	call   c010034c <cprintf>
c0102f68:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102f6b:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0102f6e:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0102f71:	8b 40 04             	mov    0x4(%eax),%eax

		le = list_next(le);
c0102f74:	89 45 f4             	mov    %eax,-0xc(%ebp)
//print free list, used for debug
static void print_free_list()
{
	list_entry_t *le = list_next(&free_list);
	struct Page *p;
	while (le != &free_list)
c0102f77:	81 7d f4 b0 89 11 c0 	cmpl   $0xc01189b0,-0xc(%ebp)
c0102f7e:	75 c2                	jne    c0102f42 <print_free_list+0x18>

		cprintf("	%08x %d\n", p, p->property);

		le = list_next(le);
	}
}
c0102f80:	c9                   	leave  
c0102f81:	c3                   	ret    

c0102f82 <default_nr_free_pages>:

static size_t
default_nr_free_pages(void) {
c0102f82:	55                   	push   %ebp
c0102f83:	89 e5                	mov    %esp,%ebp
    return nr_free;
c0102f85:	a1 b8 89 11 c0       	mov    0xc01189b8,%eax
}
c0102f8a:	5d                   	pop    %ebp
c0102f8b:	c3                   	ret    

c0102f8c <basic_check>:

static void
basic_check(void) {
c0102f8c:	55                   	push   %ebp
c0102f8d:	89 e5                	mov    %esp,%ebp
c0102f8f:	83 ec 48             	sub    $0x48,%esp
    struct Page *p0, *p1, *p2;
    p0 = p1 = p2 = NULL;
c0102f92:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0102f99:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102f9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0102f9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0102fa2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    assert((p0 = alloc_page()) != NULL);
c0102fa5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0102fac:	e8 85 0e 00 00       	call   c0103e36 <alloc_pages>
c0102fb1:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0102fb4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
c0102fb8:	75 24                	jne    c0102fde <basic_check+0x52>
c0102fba:	c7 44 24 0c 5b 68 10 	movl   $0xc010685b,0xc(%esp)
c0102fc1:	c0 
c0102fc2:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0102fc9:	c0 
c0102fca:	c7 44 24 04 c6 00 00 	movl   $0xc6,0x4(%esp)
c0102fd1:	00 
c0102fd2:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0102fd9:	e8 36 dd ff ff       	call   c0100d14 <__panic>
    assert((p1 = alloc_page()) != NULL);
c0102fde:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0102fe5:	e8 4c 0e 00 00       	call   c0103e36 <alloc_pages>
c0102fea:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0102fed:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0102ff1:	75 24                	jne    c0103017 <basic_check+0x8b>
c0102ff3:	c7 44 24 0c 77 68 10 	movl   $0xc0106877,0xc(%esp)
c0102ffa:	c0 
c0102ffb:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103002:	c0 
c0103003:	c7 44 24 04 c7 00 00 	movl   $0xc7,0x4(%esp)
c010300a:	00 
c010300b:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103012:	e8 fd dc ff ff       	call   c0100d14 <__panic>
    assert((p2 = alloc_page()) != NULL);
c0103017:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c010301e:	e8 13 0e 00 00       	call   c0103e36 <alloc_pages>
c0103023:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0103026:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c010302a:	75 24                	jne    c0103050 <basic_check+0xc4>
c010302c:	c7 44 24 0c 93 68 10 	movl   $0xc0106893,0xc(%esp)
c0103033:	c0 
c0103034:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c010303b:	c0 
c010303c:	c7 44 24 04 c8 00 00 	movl   $0xc8,0x4(%esp)
c0103043:	00 
c0103044:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c010304b:	e8 c4 dc ff ff       	call   c0100d14 <__panic>

    assert(p0 != p1 && p0 != p2 && p1 != p2);
c0103050:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103053:	3b 45 f0             	cmp    -0x10(%ebp),%eax
c0103056:	74 10                	je     c0103068 <basic_check+0xdc>
c0103058:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010305b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c010305e:	74 08                	je     c0103068 <basic_check+0xdc>
c0103060:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103063:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c0103066:	75 24                	jne    c010308c <basic_check+0x100>
c0103068:	c7 44 24 0c b0 68 10 	movl   $0xc01068b0,0xc(%esp)
c010306f:	c0 
c0103070:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103077:	c0 
c0103078:	c7 44 24 04 ca 00 00 	movl   $0xca,0x4(%esp)
c010307f:	00 
c0103080:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103087:	e8 88 dc ff ff       	call   c0100d14 <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
c010308c:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010308f:	89 04 24             	mov    %eax,(%esp)
c0103092:	e8 6a f9 ff ff       	call   c0102a01 <page_ref>
c0103097:	85 c0                	test   %eax,%eax
c0103099:	75 1e                	jne    c01030b9 <basic_check+0x12d>
c010309b:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010309e:	89 04 24             	mov    %eax,(%esp)
c01030a1:	e8 5b f9 ff ff       	call   c0102a01 <page_ref>
c01030a6:	85 c0                	test   %eax,%eax
c01030a8:	75 0f                	jne    c01030b9 <basic_check+0x12d>
c01030aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01030ad:	89 04 24             	mov    %eax,(%esp)
c01030b0:	e8 4c f9 ff ff       	call   c0102a01 <page_ref>
c01030b5:	85 c0                	test   %eax,%eax
c01030b7:	74 24                	je     c01030dd <basic_check+0x151>
c01030b9:	c7 44 24 0c d4 68 10 	movl   $0xc01068d4,0xc(%esp)
c01030c0:	c0 
c01030c1:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c01030c8:	c0 
c01030c9:	c7 44 24 04 cb 00 00 	movl   $0xcb,0x4(%esp)
c01030d0:	00 
c01030d1:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c01030d8:	e8 37 dc ff ff       	call   c0100d14 <__panic>

    assert(page2pa(p0) < npage * PGSIZE);
c01030dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01030e0:	89 04 24             	mov    %eax,(%esp)
c01030e3:	e8 03 f9 ff ff       	call   c01029eb <page2pa>
c01030e8:	8b 15 c0 88 11 c0    	mov    0xc01188c0,%edx
c01030ee:	c1 e2 0c             	shl    $0xc,%edx
c01030f1:	39 d0                	cmp    %edx,%eax
c01030f3:	72 24                	jb     c0103119 <basic_check+0x18d>
c01030f5:	c7 44 24 0c 10 69 10 	movl   $0xc0106910,0xc(%esp)
c01030fc:	c0 
c01030fd:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103104:	c0 
c0103105:	c7 44 24 04 cd 00 00 	movl   $0xcd,0x4(%esp)
c010310c:	00 
c010310d:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103114:	e8 fb db ff ff       	call   c0100d14 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
c0103119:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010311c:	89 04 24             	mov    %eax,(%esp)
c010311f:	e8 c7 f8 ff ff       	call   c01029eb <page2pa>
c0103124:	8b 15 c0 88 11 c0    	mov    0xc01188c0,%edx
c010312a:	c1 e2 0c             	shl    $0xc,%edx
c010312d:	39 d0                	cmp    %edx,%eax
c010312f:	72 24                	jb     c0103155 <basic_check+0x1c9>
c0103131:	c7 44 24 0c 2d 69 10 	movl   $0xc010692d,0xc(%esp)
c0103138:	c0 
c0103139:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103140:	c0 
c0103141:	c7 44 24 04 ce 00 00 	movl   $0xce,0x4(%esp)
c0103148:	00 
c0103149:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103150:	e8 bf db ff ff       	call   c0100d14 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
c0103155:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103158:	89 04 24             	mov    %eax,(%esp)
c010315b:	e8 8b f8 ff ff       	call   c01029eb <page2pa>
c0103160:	8b 15 c0 88 11 c0    	mov    0xc01188c0,%edx
c0103166:	c1 e2 0c             	shl    $0xc,%edx
c0103169:	39 d0                	cmp    %edx,%eax
c010316b:	72 24                	jb     c0103191 <basic_check+0x205>
c010316d:	c7 44 24 0c 4a 69 10 	movl   $0xc010694a,0xc(%esp)
c0103174:	c0 
c0103175:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c010317c:	c0 
c010317d:	c7 44 24 04 cf 00 00 	movl   $0xcf,0x4(%esp)
c0103184:	00 
c0103185:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c010318c:	e8 83 db ff ff       	call   c0100d14 <__panic>

    list_entry_t free_list_store = free_list;
c0103191:	a1 b0 89 11 c0       	mov    0xc01189b0,%eax
c0103196:	8b 15 b4 89 11 c0    	mov    0xc01189b4,%edx
c010319c:	89 45 d0             	mov    %eax,-0x30(%ebp)
c010319f:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c01031a2:	c7 45 e0 b0 89 11 c0 	movl   $0xc01189b0,-0x20(%ebp)
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
c01031a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01031ac:	8b 55 e0             	mov    -0x20(%ebp),%edx
c01031af:	89 50 04             	mov    %edx,0x4(%eax)
c01031b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01031b5:	8b 50 04             	mov    0x4(%eax),%edx
c01031b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01031bb:	89 10                	mov    %edx,(%eax)
c01031bd:	c7 45 dc b0 89 11 c0 	movl   $0xc01189b0,-0x24(%ebp)
 * list_empty - tests whether a list is empty
 * @list:       the list to test.
 * */
static inline bool
list_empty(list_entry_t *list) {
    return list->next == list;
c01031c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01031c7:	8b 40 04             	mov    0x4(%eax),%eax
c01031ca:	39 45 dc             	cmp    %eax,-0x24(%ebp)
c01031cd:	0f 94 c0             	sete   %al
c01031d0:	0f b6 c0             	movzbl %al,%eax
    list_init(&free_list);
    assert(list_empty(&free_list));
c01031d3:	85 c0                	test   %eax,%eax
c01031d5:	75 24                	jne    c01031fb <basic_check+0x26f>
c01031d7:	c7 44 24 0c 67 69 10 	movl   $0xc0106967,0xc(%esp)
c01031de:	c0 
c01031df:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c01031e6:	c0 
c01031e7:	c7 44 24 04 d3 00 00 	movl   $0xd3,0x4(%esp)
c01031ee:	00 
c01031ef:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c01031f6:	e8 19 db ff ff       	call   c0100d14 <__panic>

    unsigned int nr_free_store = nr_free;
c01031fb:	a1 b8 89 11 c0       	mov    0xc01189b8,%eax
c0103200:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nr_free = 0;
c0103203:	c7 05 b8 89 11 c0 00 	movl   $0x0,0xc01189b8
c010320a:	00 00 00 

    assert(alloc_page() == NULL);
c010320d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0103214:	e8 1d 0c 00 00       	call   c0103e36 <alloc_pages>
c0103219:	85 c0                	test   %eax,%eax
c010321b:	74 24                	je     c0103241 <basic_check+0x2b5>
c010321d:	c7 44 24 0c 7e 69 10 	movl   $0xc010697e,0xc(%esp)
c0103224:	c0 
c0103225:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c010322c:	c0 
c010322d:	c7 44 24 04 d8 00 00 	movl   $0xd8,0x4(%esp)
c0103234:	00 
c0103235:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c010323c:	e8 d3 da ff ff       	call   c0100d14 <__panic>

    free_page(p0);
c0103241:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c0103248:	00 
c0103249:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010324c:	89 04 24             	mov    %eax,(%esp)
c010324f:	e8 1a 0c 00 00       	call   c0103e6e <free_pages>
    free_page(p1);
c0103254:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c010325b:	00 
c010325c:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010325f:	89 04 24             	mov    %eax,(%esp)
c0103262:	e8 07 0c 00 00       	call   c0103e6e <free_pages>
    free_page(p2);
c0103267:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c010326e:	00 
c010326f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103272:	89 04 24             	mov    %eax,(%esp)
c0103275:	e8 f4 0b 00 00       	call   c0103e6e <free_pages>
    assert(nr_free == 3);
c010327a:	a1 b8 89 11 c0       	mov    0xc01189b8,%eax
c010327f:	83 f8 03             	cmp    $0x3,%eax
c0103282:	74 24                	je     c01032a8 <basic_check+0x31c>
c0103284:	c7 44 24 0c 93 69 10 	movl   $0xc0106993,0xc(%esp)
c010328b:	c0 
c010328c:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103293:	c0 
c0103294:	c7 44 24 04 dd 00 00 	movl   $0xdd,0x4(%esp)
c010329b:	00 
c010329c:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c01032a3:	e8 6c da ff ff       	call   c0100d14 <__panic>

    assert((p0 = alloc_page()) != NULL);
c01032a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c01032af:	e8 82 0b 00 00       	call   c0103e36 <alloc_pages>
c01032b4:	89 45 ec             	mov    %eax,-0x14(%ebp)
c01032b7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
c01032bb:	75 24                	jne    c01032e1 <basic_check+0x355>
c01032bd:	c7 44 24 0c 5b 68 10 	movl   $0xc010685b,0xc(%esp)
c01032c4:	c0 
c01032c5:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c01032cc:	c0 
c01032cd:	c7 44 24 04 df 00 00 	movl   $0xdf,0x4(%esp)
c01032d4:	00 
c01032d5:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c01032dc:	e8 33 da ff ff       	call   c0100d14 <__panic>
    assert((p1 = alloc_page()) != NULL);
c01032e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c01032e8:	e8 49 0b 00 00       	call   c0103e36 <alloc_pages>
c01032ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01032f0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c01032f4:	75 24                	jne    c010331a <basic_check+0x38e>
c01032f6:	c7 44 24 0c 77 68 10 	movl   $0xc0106877,0xc(%esp)
c01032fd:	c0 
c01032fe:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103305:	c0 
c0103306:	c7 44 24 04 e0 00 00 	movl   $0xe0,0x4(%esp)
c010330d:	00 
c010330e:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103315:	e8 fa d9 ff ff       	call   c0100d14 <__panic>
    assert((p2 = alloc_page()) != NULL);
c010331a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0103321:	e8 10 0b 00 00       	call   c0103e36 <alloc_pages>
c0103326:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0103329:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c010332d:	75 24                	jne    c0103353 <basic_check+0x3c7>
c010332f:	c7 44 24 0c 93 68 10 	movl   $0xc0106893,0xc(%esp)
c0103336:	c0 
c0103337:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c010333e:	c0 
c010333f:	c7 44 24 04 e1 00 00 	movl   $0xe1,0x4(%esp)
c0103346:	00 
c0103347:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c010334e:	e8 c1 d9 ff ff       	call   c0100d14 <__panic>

    assert(alloc_page() == NULL);
c0103353:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c010335a:	e8 d7 0a 00 00       	call   c0103e36 <alloc_pages>
c010335f:	85 c0                	test   %eax,%eax
c0103361:	74 24                	je     c0103387 <basic_check+0x3fb>
c0103363:	c7 44 24 0c 7e 69 10 	movl   $0xc010697e,0xc(%esp)
c010336a:	c0 
c010336b:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103372:	c0 
c0103373:	c7 44 24 04 e3 00 00 	movl   $0xe3,0x4(%esp)
c010337a:	00 
c010337b:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103382:	e8 8d d9 ff ff       	call   c0100d14 <__panic>

    free_page(p0);
c0103387:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c010338e:	00 
c010338f:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103392:	89 04 24             	mov    %eax,(%esp)
c0103395:	e8 d4 0a 00 00       	call   c0103e6e <free_pages>
c010339a:	c7 45 d8 b0 89 11 c0 	movl   $0xc01189b0,-0x28(%ebp)
c01033a1:	8b 45 d8             	mov    -0x28(%ebp),%eax
c01033a4:	8b 40 04             	mov    0x4(%eax),%eax
c01033a7:	39 45 d8             	cmp    %eax,-0x28(%ebp)
c01033aa:	0f 94 c0             	sete   %al
c01033ad:	0f b6 c0             	movzbl %al,%eax
    assert(!list_empty(&free_list));
c01033b0:	85 c0                	test   %eax,%eax
c01033b2:	74 24                	je     c01033d8 <basic_check+0x44c>
c01033b4:	c7 44 24 0c a0 69 10 	movl   $0xc01069a0,0xc(%esp)
c01033bb:	c0 
c01033bc:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c01033c3:	c0 
c01033c4:	c7 44 24 04 e6 00 00 	movl   $0xe6,0x4(%esp)
c01033cb:	00 
c01033cc:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c01033d3:	e8 3c d9 ff ff       	call   c0100d14 <__panic>

    struct Page *p;
    assert((p = alloc_page()) == p0);
c01033d8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c01033df:	e8 52 0a 00 00       	call   c0103e36 <alloc_pages>
c01033e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c01033e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01033ea:	3b 45 ec             	cmp    -0x14(%ebp),%eax
c01033ed:	74 24                	je     c0103413 <basic_check+0x487>
c01033ef:	c7 44 24 0c b8 69 10 	movl   $0xc01069b8,0xc(%esp)
c01033f6:	c0 
c01033f7:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c01033fe:	c0 
c01033ff:	c7 44 24 04 e9 00 00 	movl   $0xe9,0x4(%esp)
c0103406:	00 
c0103407:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c010340e:	e8 01 d9 ff ff       	call   c0100d14 <__panic>
    assert(alloc_page() == NULL);
c0103413:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c010341a:	e8 17 0a 00 00       	call   c0103e36 <alloc_pages>
c010341f:	85 c0                	test   %eax,%eax
c0103421:	74 24                	je     c0103447 <basic_check+0x4bb>
c0103423:	c7 44 24 0c 7e 69 10 	movl   $0xc010697e,0xc(%esp)
c010342a:	c0 
c010342b:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103432:	c0 
c0103433:	c7 44 24 04 ea 00 00 	movl   $0xea,0x4(%esp)
c010343a:	00 
c010343b:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103442:	e8 cd d8 ff ff       	call   c0100d14 <__panic>

    assert(nr_free == 0);
c0103447:	a1 b8 89 11 c0       	mov    0xc01189b8,%eax
c010344c:	85 c0                	test   %eax,%eax
c010344e:	74 24                	je     c0103474 <basic_check+0x4e8>
c0103450:	c7 44 24 0c d1 69 10 	movl   $0xc01069d1,0xc(%esp)
c0103457:	c0 
c0103458:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c010345f:	c0 
c0103460:	c7 44 24 04 ec 00 00 	movl   $0xec,0x4(%esp)
c0103467:	00 
c0103468:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c010346f:	e8 a0 d8 ff ff       	call   c0100d14 <__panic>
    free_list = free_list_store;
c0103474:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0103477:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c010347a:	a3 b0 89 11 c0       	mov    %eax,0xc01189b0
c010347f:	89 15 b4 89 11 c0    	mov    %edx,0xc01189b4
    nr_free = nr_free_store;
c0103485:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0103488:	a3 b8 89 11 c0       	mov    %eax,0xc01189b8

    free_page(p);
c010348d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c0103494:	00 
c0103495:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103498:	89 04 24             	mov    %eax,(%esp)
c010349b:	e8 ce 09 00 00       	call   c0103e6e <free_pages>
    free_page(p1);
c01034a0:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c01034a7:	00 
c01034a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01034ab:	89 04 24             	mov    %eax,(%esp)
c01034ae:	e8 bb 09 00 00       	call   c0103e6e <free_pages>
    free_page(p2);
c01034b3:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c01034ba:	00 
c01034bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01034be:	89 04 24             	mov    %eax,(%esp)
c01034c1:	e8 a8 09 00 00       	call   c0103e6e <free_pages>
}
c01034c6:	c9                   	leave  
c01034c7:	c3                   	ret    

c01034c8 <default_check>:

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
c01034c8:	55                   	push   %ebp
c01034c9:	89 e5                	mov    %esp,%ebp
c01034cb:	53                   	push   %ebx
c01034cc:	81 ec 94 00 00 00    	sub    $0x94,%esp
    int count = 0, total = 0;
c01034d2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c01034d9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    list_entry_t *le = &free_list;
c01034e0:	c7 45 ec b0 89 11 c0 	movl   $0xc01189b0,-0x14(%ebp)
    while ((le = list_next(le)) != &free_list) {
c01034e7:	eb 6b                	jmp    c0103554 <default_check+0x8c>
        struct Page *p = le2page(le, page_link);
c01034e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01034ec:	83 e8 0c             	sub    $0xc,%eax
c01034ef:	89 45 e8             	mov    %eax,-0x18(%ebp)
        assert(PageProperty(p));
c01034f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01034f5:	83 c0 04             	add    $0x4,%eax
c01034f8:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
c01034ff:	89 45 cc             	mov    %eax,-0x34(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0103502:	8b 45 cc             	mov    -0x34(%ebp),%eax
c0103505:	8b 55 d0             	mov    -0x30(%ebp),%edx
c0103508:	0f a3 10             	bt     %edx,(%eax)
c010350b:	19 c0                	sbb    %eax,%eax
c010350d:	89 45 c8             	mov    %eax,-0x38(%ebp)
    return oldbit != 0;
c0103510:	83 7d c8 00          	cmpl   $0x0,-0x38(%ebp)
c0103514:	0f 95 c0             	setne  %al
c0103517:	0f b6 c0             	movzbl %al,%eax
c010351a:	85 c0                	test   %eax,%eax
c010351c:	75 24                	jne    c0103542 <default_check+0x7a>
c010351e:	c7 44 24 0c de 69 10 	movl   $0xc01069de,0xc(%esp)
c0103525:	c0 
c0103526:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c010352d:	c0 
c010352e:	c7 44 24 04 fd 00 00 	movl   $0xfd,0x4(%esp)
c0103535:	00 
c0103536:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c010353d:	e8 d2 d7 ff ff       	call   c0100d14 <__panic>
        count ++, total += p->property;
c0103542:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0103546:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0103549:	8b 50 08             	mov    0x8(%eax),%edx
c010354c:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010354f:	01 d0                	add    %edx,%eax
c0103551:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0103554:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103557:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
c010355a:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c010355d:	8b 40 04             	mov    0x4(%eax),%eax
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
c0103560:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0103563:	81 7d ec b0 89 11 c0 	cmpl   $0xc01189b0,-0x14(%ebp)
c010356a:	0f 85 79 ff ff ff    	jne    c01034e9 <default_check+0x21>
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
        count ++, total += p->property;
    }
    assert(total == nr_free_pages());
c0103570:	8b 5d f0             	mov    -0x10(%ebp),%ebx
c0103573:	e8 28 09 00 00       	call   c0103ea0 <nr_free_pages>
c0103578:	39 c3                	cmp    %eax,%ebx
c010357a:	74 24                	je     c01035a0 <default_check+0xd8>
c010357c:	c7 44 24 0c ee 69 10 	movl   $0xc01069ee,0xc(%esp)
c0103583:	c0 
c0103584:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c010358b:	c0 
c010358c:	c7 44 24 04 00 01 00 	movl   $0x100,0x4(%esp)
c0103593:	00 
c0103594:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c010359b:	e8 74 d7 ff ff       	call   c0100d14 <__panic>

    basic_check();
c01035a0:	e8 e7 f9 ff ff       	call   c0102f8c <basic_check>

    struct Page *p0 = alloc_pages(5), *p1, *p2;
c01035a5:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
c01035ac:	e8 85 08 00 00       	call   c0103e36 <alloc_pages>
c01035b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    assert(p0 != NULL);
c01035b4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c01035b8:	75 24                	jne    c01035de <default_check+0x116>
c01035ba:	c7 44 24 0c 07 6a 10 	movl   $0xc0106a07,0xc(%esp)
c01035c1:	c0 
c01035c2:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c01035c9:	c0 
c01035ca:	c7 44 24 04 05 01 00 	movl   $0x105,0x4(%esp)
c01035d1:	00 
c01035d2:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c01035d9:	e8 36 d7 ff ff       	call   c0100d14 <__panic>
    assert(!PageProperty(p0));
c01035de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01035e1:	83 c0 04             	add    $0x4,%eax
c01035e4:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
c01035eb:	89 45 bc             	mov    %eax,-0x44(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c01035ee:	8b 45 bc             	mov    -0x44(%ebp),%eax
c01035f1:	8b 55 c0             	mov    -0x40(%ebp),%edx
c01035f4:	0f a3 10             	bt     %edx,(%eax)
c01035f7:	19 c0                	sbb    %eax,%eax
c01035f9:	89 45 b8             	mov    %eax,-0x48(%ebp)
    return oldbit != 0;
c01035fc:	83 7d b8 00          	cmpl   $0x0,-0x48(%ebp)
c0103600:	0f 95 c0             	setne  %al
c0103603:	0f b6 c0             	movzbl %al,%eax
c0103606:	85 c0                	test   %eax,%eax
c0103608:	74 24                	je     c010362e <default_check+0x166>
c010360a:	c7 44 24 0c 12 6a 10 	movl   $0xc0106a12,0xc(%esp)
c0103611:	c0 
c0103612:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103619:	c0 
c010361a:	c7 44 24 04 06 01 00 	movl   $0x106,0x4(%esp)
c0103621:	00 
c0103622:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103629:	e8 e6 d6 ff ff       	call   c0100d14 <__panic>

    list_entry_t free_list_store = free_list;
c010362e:	a1 b0 89 11 c0       	mov    0xc01189b0,%eax
c0103633:	8b 15 b4 89 11 c0    	mov    0xc01189b4,%edx
c0103639:	89 45 80             	mov    %eax,-0x80(%ebp)
c010363c:	89 55 84             	mov    %edx,-0x7c(%ebp)
c010363f:	c7 45 b4 b0 89 11 c0 	movl   $0xc01189b0,-0x4c(%ebp)
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
c0103646:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0103649:	8b 55 b4             	mov    -0x4c(%ebp),%edx
c010364c:	89 50 04             	mov    %edx,0x4(%eax)
c010364f:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0103652:	8b 50 04             	mov    0x4(%eax),%edx
c0103655:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0103658:	89 10                	mov    %edx,(%eax)
c010365a:	c7 45 b0 b0 89 11 c0 	movl   $0xc01189b0,-0x50(%ebp)
 * list_empty - tests whether a list is empty
 * @list:       the list to test.
 * */
static inline bool
list_empty(list_entry_t *list) {
    return list->next == list;
c0103661:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0103664:	8b 40 04             	mov    0x4(%eax),%eax
c0103667:	39 45 b0             	cmp    %eax,-0x50(%ebp)
c010366a:	0f 94 c0             	sete   %al
c010366d:	0f b6 c0             	movzbl %al,%eax
    list_init(&free_list);
    assert(list_empty(&free_list));
c0103670:	85 c0                	test   %eax,%eax
c0103672:	75 24                	jne    c0103698 <default_check+0x1d0>
c0103674:	c7 44 24 0c 67 69 10 	movl   $0xc0106967,0xc(%esp)
c010367b:	c0 
c010367c:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103683:	c0 
c0103684:	c7 44 24 04 0a 01 00 	movl   $0x10a,0x4(%esp)
c010368b:	00 
c010368c:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103693:	e8 7c d6 ff ff       	call   c0100d14 <__panic>
    assert(alloc_page() == NULL);
c0103698:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c010369f:	e8 92 07 00 00       	call   c0103e36 <alloc_pages>
c01036a4:	85 c0                	test   %eax,%eax
c01036a6:	74 24                	je     c01036cc <default_check+0x204>
c01036a8:	c7 44 24 0c 7e 69 10 	movl   $0xc010697e,0xc(%esp)
c01036af:	c0 
c01036b0:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c01036b7:	c0 
c01036b8:	c7 44 24 04 0b 01 00 	movl   $0x10b,0x4(%esp)
c01036bf:	00 
c01036c0:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c01036c7:	e8 48 d6 ff ff       	call   c0100d14 <__panic>

    unsigned int nr_free_store = nr_free;
c01036cc:	a1 b8 89 11 c0       	mov    0xc01189b8,%eax
c01036d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nr_free = 0;
c01036d4:	c7 05 b8 89 11 c0 00 	movl   $0x0,0xc01189b8
c01036db:	00 00 00 

    free_pages(p0 + 2, 3);
c01036de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01036e1:	83 c0 28             	add    $0x28,%eax
c01036e4:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
c01036eb:	00 
c01036ec:	89 04 24             	mov    %eax,(%esp)
c01036ef:	e8 7a 07 00 00       	call   c0103e6e <free_pages>
    assert(alloc_pages(4) == NULL);
c01036f4:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
c01036fb:	e8 36 07 00 00       	call   c0103e36 <alloc_pages>
c0103700:	85 c0                	test   %eax,%eax
c0103702:	74 24                	je     c0103728 <default_check+0x260>
c0103704:	c7 44 24 0c 24 6a 10 	movl   $0xc0106a24,0xc(%esp)
c010370b:	c0 
c010370c:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103713:	c0 
c0103714:	c7 44 24 04 11 01 00 	movl   $0x111,0x4(%esp)
c010371b:	00 
c010371c:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103723:	e8 ec d5 ff ff       	call   c0100d14 <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
c0103728:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010372b:	83 c0 28             	add    $0x28,%eax
c010372e:	83 c0 04             	add    $0x4,%eax
c0103731:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
c0103738:	89 45 a8             	mov    %eax,-0x58(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c010373b:	8b 45 a8             	mov    -0x58(%ebp),%eax
c010373e:	8b 55 ac             	mov    -0x54(%ebp),%edx
c0103741:	0f a3 10             	bt     %edx,(%eax)
c0103744:	19 c0                	sbb    %eax,%eax
c0103746:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    return oldbit != 0;
c0103749:	83 7d a4 00          	cmpl   $0x0,-0x5c(%ebp)
c010374d:	0f 95 c0             	setne  %al
c0103750:	0f b6 c0             	movzbl %al,%eax
c0103753:	85 c0                	test   %eax,%eax
c0103755:	74 0e                	je     c0103765 <default_check+0x29d>
c0103757:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010375a:	83 c0 28             	add    $0x28,%eax
c010375d:	8b 40 08             	mov    0x8(%eax),%eax
c0103760:	83 f8 03             	cmp    $0x3,%eax
c0103763:	74 24                	je     c0103789 <default_check+0x2c1>
c0103765:	c7 44 24 0c 3c 6a 10 	movl   $0xc0106a3c,0xc(%esp)
c010376c:	c0 
c010376d:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103774:	c0 
c0103775:	c7 44 24 04 12 01 00 	movl   $0x112,0x4(%esp)
c010377c:	00 
c010377d:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103784:	e8 8b d5 ff ff       	call   c0100d14 <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
c0103789:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
c0103790:	e8 a1 06 00 00       	call   c0103e36 <alloc_pages>
c0103795:	89 45 dc             	mov    %eax,-0x24(%ebp)
c0103798:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
c010379c:	75 24                	jne    c01037c2 <default_check+0x2fa>
c010379e:	c7 44 24 0c 68 6a 10 	movl   $0xc0106a68,0xc(%esp)
c01037a5:	c0 
c01037a6:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c01037ad:	c0 
c01037ae:	c7 44 24 04 13 01 00 	movl   $0x113,0x4(%esp)
c01037b5:	00 
c01037b6:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c01037bd:	e8 52 d5 ff ff       	call   c0100d14 <__panic>
    assert(alloc_page() == NULL);
c01037c2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c01037c9:	e8 68 06 00 00       	call   c0103e36 <alloc_pages>
c01037ce:	85 c0                	test   %eax,%eax
c01037d0:	74 24                	je     c01037f6 <default_check+0x32e>
c01037d2:	c7 44 24 0c 7e 69 10 	movl   $0xc010697e,0xc(%esp)
c01037d9:	c0 
c01037da:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c01037e1:	c0 
c01037e2:	c7 44 24 04 14 01 00 	movl   $0x114,0x4(%esp)
c01037e9:	00 
c01037ea:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c01037f1:	e8 1e d5 ff ff       	call   c0100d14 <__panic>
    assert(p0 + 2 == p1);
c01037f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01037f9:	83 c0 28             	add    $0x28,%eax
c01037fc:	3b 45 dc             	cmp    -0x24(%ebp),%eax
c01037ff:	74 24                	je     c0103825 <default_check+0x35d>
c0103801:	c7 44 24 0c 86 6a 10 	movl   $0xc0106a86,0xc(%esp)
c0103808:	c0 
c0103809:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103810:	c0 
c0103811:	c7 44 24 04 15 01 00 	movl   $0x115,0x4(%esp)
c0103818:	00 
c0103819:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103820:	e8 ef d4 ff ff       	call   c0100d14 <__panic>

    p2 = p0 + 1;
c0103825:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103828:	83 c0 14             	add    $0x14,%eax
c010382b:	89 45 d8             	mov    %eax,-0x28(%ebp)
    free_page(p0);
c010382e:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c0103835:	00 
c0103836:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103839:	89 04 24             	mov    %eax,(%esp)
c010383c:	e8 2d 06 00 00       	call   c0103e6e <free_pages>
    free_pages(p1, 3);
c0103841:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
c0103848:	00 
c0103849:	8b 45 dc             	mov    -0x24(%ebp),%eax
c010384c:	89 04 24             	mov    %eax,(%esp)
c010384f:	e8 1a 06 00 00       	call   c0103e6e <free_pages>
    assert(PageProperty(p0) && p0->property == 1);
c0103854:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103857:	83 c0 04             	add    $0x4,%eax
c010385a:	c7 45 a0 01 00 00 00 	movl   $0x1,-0x60(%ebp)
c0103861:	89 45 9c             	mov    %eax,-0x64(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0103864:	8b 45 9c             	mov    -0x64(%ebp),%eax
c0103867:	8b 55 a0             	mov    -0x60(%ebp),%edx
c010386a:	0f a3 10             	bt     %edx,(%eax)
c010386d:	19 c0                	sbb    %eax,%eax
c010386f:	89 45 98             	mov    %eax,-0x68(%ebp)
    return oldbit != 0;
c0103872:	83 7d 98 00          	cmpl   $0x0,-0x68(%ebp)
c0103876:	0f 95 c0             	setne  %al
c0103879:	0f b6 c0             	movzbl %al,%eax
c010387c:	85 c0                	test   %eax,%eax
c010387e:	74 0b                	je     c010388b <default_check+0x3c3>
c0103880:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103883:	8b 40 08             	mov    0x8(%eax),%eax
c0103886:	83 f8 01             	cmp    $0x1,%eax
c0103889:	74 24                	je     c01038af <default_check+0x3e7>
c010388b:	c7 44 24 0c 94 6a 10 	movl   $0xc0106a94,0xc(%esp)
c0103892:	c0 
c0103893:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c010389a:	c0 
c010389b:	c7 44 24 04 1a 01 00 	movl   $0x11a,0x4(%esp)
c01038a2:	00 
c01038a3:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c01038aa:	e8 65 d4 ff ff       	call   c0100d14 <__panic>
    assert(PageProperty(p1) && p1->property == 3);
c01038af:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01038b2:	83 c0 04             	add    $0x4,%eax
c01038b5:	c7 45 94 01 00 00 00 	movl   $0x1,-0x6c(%ebp)
c01038bc:	89 45 90             	mov    %eax,-0x70(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c01038bf:	8b 45 90             	mov    -0x70(%ebp),%eax
c01038c2:	8b 55 94             	mov    -0x6c(%ebp),%edx
c01038c5:	0f a3 10             	bt     %edx,(%eax)
c01038c8:	19 c0                	sbb    %eax,%eax
c01038ca:	89 45 8c             	mov    %eax,-0x74(%ebp)
    return oldbit != 0;
c01038cd:	83 7d 8c 00          	cmpl   $0x0,-0x74(%ebp)
c01038d1:	0f 95 c0             	setne  %al
c01038d4:	0f b6 c0             	movzbl %al,%eax
c01038d7:	85 c0                	test   %eax,%eax
c01038d9:	74 0b                	je     c01038e6 <default_check+0x41e>
c01038db:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01038de:	8b 40 08             	mov    0x8(%eax),%eax
c01038e1:	83 f8 03             	cmp    $0x3,%eax
c01038e4:	74 24                	je     c010390a <default_check+0x442>
c01038e6:	c7 44 24 0c bc 6a 10 	movl   $0xc0106abc,0xc(%esp)
c01038ed:	c0 
c01038ee:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c01038f5:	c0 
c01038f6:	c7 44 24 04 1b 01 00 	movl   $0x11b,0x4(%esp)
c01038fd:	00 
c01038fe:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103905:	e8 0a d4 ff ff       	call   c0100d14 <__panic>

    assert((p0 = alloc_page()) == p2 - 1);
c010390a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0103911:	e8 20 05 00 00       	call   c0103e36 <alloc_pages>
c0103916:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0103919:	8b 45 d8             	mov    -0x28(%ebp),%eax
c010391c:	83 e8 14             	sub    $0x14,%eax
c010391f:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
c0103922:	74 24                	je     c0103948 <default_check+0x480>
c0103924:	c7 44 24 0c e2 6a 10 	movl   $0xc0106ae2,0xc(%esp)
c010392b:	c0 
c010392c:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103933:	c0 
c0103934:	c7 44 24 04 1d 01 00 	movl   $0x11d,0x4(%esp)
c010393b:	00 
c010393c:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103943:	e8 cc d3 ff ff       	call   c0100d14 <__panic>
    free_page(p0);
c0103948:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c010394f:	00 
c0103950:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103953:	89 04 24             	mov    %eax,(%esp)
c0103956:	e8 13 05 00 00       	call   c0103e6e <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
c010395b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
c0103962:	e8 cf 04 00 00       	call   c0103e36 <alloc_pages>
c0103967:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c010396a:	8b 45 d8             	mov    -0x28(%ebp),%eax
c010396d:	83 c0 14             	add    $0x14,%eax
c0103970:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
c0103973:	74 24                	je     c0103999 <default_check+0x4d1>
c0103975:	c7 44 24 0c 00 6b 10 	movl   $0xc0106b00,0xc(%esp)
c010397c:	c0 
c010397d:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103984:	c0 
c0103985:	c7 44 24 04 1f 01 00 	movl   $0x11f,0x4(%esp)
c010398c:	00 
c010398d:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103994:	e8 7b d3 ff ff       	call   c0100d14 <__panic>

    free_pages(p0, 2);
c0103999:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
c01039a0:	00 
c01039a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01039a4:	89 04 24             	mov    %eax,(%esp)
c01039a7:	e8 c2 04 00 00       	call   c0103e6e <free_pages>
    free_page(p2);
c01039ac:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c01039b3:	00 
c01039b4:	8b 45 d8             	mov    -0x28(%ebp),%eax
c01039b7:	89 04 24             	mov    %eax,(%esp)
c01039ba:	e8 af 04 00 00       	call   c0103e6e <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
c01039bf:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
c01039c6:	e8 6b 04 00 00       	call   c0103e36 <alloc_pages>
c01039cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c01039ce:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c01039d2:	75 24                	jne    c01039f8 <default_check+0x530>
c01039d4:	c7 44 24 0c 20 6b 10 	movl   $0xc0106b20,0xc(%esp)
c01039db:	c0 
c01039dc:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c01039e3:	c0 
c01039e4:	c7 44 24 04 24 01 00 	movl   $0x124,0x4(%esp)
c01039eb:	00 
c01039ec:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c01039f3:	e8 1c d3 ff ff       	call   c0100d14 <__panic>
    assert(alloc_page() == NULL);
c01039f8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c01039ff:	e8 32 04 00 00       	call   c0103e36 <alloc_pages>
c0103a04:	85 c0                	test   %eax,%eax
c0103a06:	74 24                	je     c0103a2c <default_check+0x564>
c0103a08:	c7 44 24 0c 7e 69 10 	movl   $0xc010697e,0xc(%esp)
c0103a0f:	c0 
c0103a10:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103a17:	c0 
c0103a18:	c7 44 24 04 25 01 00 	movl   $0x125,0x4(%esp)
c0103a1f:	00 
c0103a20:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103a27:	e8 e8 d2 ff ff       	call   c0100d14 <__panic>

    assert(nr_free == 0);
c0103a2c:	a1 b8 89 11 c0       	mov    0xc01189b8,%eax
c0103a31:	85 c0                	test   %eax,%eax
c0103a33:	74 24                	je     c0103a59 <default_check+0x591>
c0103a35:	c7 44 24 0c d1 69 10 	movl   $0xc01069d1,0xc(%esp)
c0103a3c:	c0 
c0103a3d:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103a44:	c0 
c0103a45:	c7 44 24 04 27 01 00 	movl   $0x127,0x4(%esp)
c0103a4c:	00 
c0103a4d:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103a54:	e8 bb d2 ff ff       	call   c0100d14 <__panic>
    nr_free = nr_free_store;
c0103a59:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0103a5c:	a3 b8 89 11 c0       	mov    %eax,0xc01189b8

    free_list = free_list_store;
c0103a61:	8b 45 80             	mov    -0x80(%ebp),%eax
c0103a64:	8b 55 84             	mov    -0x7c(%ebp),%edx
c0103a67:	a3 b0 89 11 c0       	mov    %eax,0xc01189b0
c0103a6c:	89 15 b4 89 11 c0    	mov    %edx,0xc01189b4
    free_pages(p0, 5);
c0103a72:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
c0103a79:	00 
c0103a7a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103a7d:	89 04 24             	mov    %eax,(%esp)
c0103a80:	e8 e9 03 00 00       	call   c0103e6e <free_pages>

    le = &free_list;
c0103a85:	c7 45 ec b0 89 11 c0 	movl   $0xc01189b0,-0x14(%ebp)
    while ((le = list_next(le)) != &free_list) {
c0103a8c:	eb 1d                	jmp    c0103aab <default_check+0x5e3>
        struct Page *p = le2page(le, page_link);
c0103a8e:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103a91:	83 e8 0c             	sub    $0xc,%eax
c0103a94:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        count --, total -= p->property;
c0103a97:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
c0103a9b:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0103a9e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0103aa1:	8b 40 08             	mov    0x8(%eax),%eax
c0103aa4:	29 c2                	sub    %eax,%edx
c0103aa6:	89 d0                	mov    %edx,%eax
c0103aa8:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0103aab:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103aae:	89 45 88             	mov    %eax,-0x78(%ebp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
c0103ab1:	8b 45 88             	mov    -0x78(%ebp),%eax
c0103ab4:	8b 40 04             	mov    0x4(%eax),%eax

    free_list = free_list_store;
    free_pages(p0, 5);

    le = &free_list;
    while ((le = list_next(le)) != &free_list) {
c0103ab7:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0103aba:	81 7d ec b0 89 11 c0 	cmpl   $0xc01189b0,-0x14(%ebp)
c0103ac1:	75 cb                	jne    c0103a8e <default_check+0x5c6>
        struct Page *p = le2page(le, page_link);
        count --, total -= p->property;
    }
    assert(count == 0);
c0103ac3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0103ac7:	74 24                	je     c0103aed <default_check+0x625>
c0103ac9:	c7 44 24 0c 3e 6b 10 	movl   $0xc0106b3e,0xc(%esp)
c0103ad0:	c0 
c0103ad1:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103ad8:	c0 
c0103ad9:	c7 44 24 04 32 01 00 	movl   $0x132,0x4(%esp)
c0103ae0:	00 
c0103ae1:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103ae8:	e8 27 d2 ff ff       	call   c0100d14 <__panic>
    assert(total == 0);
c0103aed:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0103af1:	74 24                	je     c0103b17 <default_check+0x64f>
c0103af3:	c7 44 24 0c 49 6b 10 	movl   $0xc0106b49,0xc(%esp)
c0103afa:	c0 
c0103afb:	c7 44 24 08 16 68 10 	movl   $0xc0106816,0x8(%esp)
c0103b02:	c0 
c0103b03:	c7 44 24 04 33 01 00 	movl   $0x133,0x4(%esp)
c0103b0a:	00 
c0103b0b:	c7 04 24 2b 68 10 c0 	movl   $0xc010682b,(%esp)
c0103b12:	e8 fd d1 ff ff       	call   c0100d14 <__panic>
}
c0103b17:	81 c4 94 00 00 00    	add    $0x94,%esp
c0103b1d:	5b                   	pop    %ebx
c0103b1e:	5d                   	pop    %ebp
c0103b1f:	c3                   	ret    

c0103b20 <page2ppn>:

extern struct Page *pages;
extern size_t npage;

static inline ppn_t
page2ppn(struct Page *page) {
c0103b20:	55                   	push   %ebp
c0103b21:	89 e5                	mov    %esp,%ebp
    return page - pages;
c0103b23:	8b 55 08             	mov    0x8(%ebp),%edx
c0103b26:	a1 c4 89 11 c0       	mov    0xc01189c4,%eax
c0103b2b:	29 c2                	sub    %eax,%edx
c0103b2d:	89 d0                	mov    %edx,%eax
c0103b2f:	c1 f8 02             	sar    $0x2,%eax
c0103b32:	69 c0 cd cc cc cc    	imul   $0xcccccccd,%eax,%eax
}
c0103b38:	5d                   	pop    %ebp
c0103b39:	c3                   	ret    

c0103b3a <page2pa>:

static inline uintptr_t
page2pa(struct Page *page) {
c0103b3a:	55                   	push   %ebp
c0103b3b:	89 e5                	mov    %esp,%ebp
c0103b3d:	83 ec 04             	sub    $0x4,%esp
    return page2ppn(page) << PGSHIFT;
c0103b40:	8b 45 08             	mov    0x8(%ebp),%eax
c0103b43:	89 04 24             	mov    %eax,(%esp)
c0103b46:	e8 d5 ff ff ff       	call   c0103b20 <page2ppn>
c0103b4b:	c1 e0 0c             	shl    $0xc,%eax
}
c0103b4e:	c9                   	leave  
c0103b4f:	c3                   	ret    

c0103b50 <pa2page>:

static inline struct Page *
pa2page(uintptr_t pa) {
c0103b50:	55                   	push   %ebp
c0103b51:	89 e5                	mov    %esp,%ebp
c0103b53:	83 ec 18             	sub    $0x18,%esp
    if (PPN(pa) >= npage) {
c0103b56:	8b 45 08             	mov    0x8(%ebp),%eax
c0103b59:	c1 e8 0c             	shr    $0xc,%eax
c0103b5c:	89 c2                	mov    %eax,%edx
c0103b5e:	a1 c0 88 11 c0       	mov    0xc01188c0,%eax
c0103b63:	39 c2                	cmp    %eax,%edx
c0103b65:	72 1c                	jb     c0103b83 <pa2page+0x33>
        panic("pa2page called with invalid pa");
c0103b67:	c7 44 24 08 84 6b 10 	movl   $0xc0106b84,0x8(%esp)
c0103b6e:	c0 
c0103b6f:	c7 44 24 04 5a 00 00 	movl   $0x5a,0x4(%esp)
c0103b76:	00 
c0103b77:	c7 04 24 a3 6b 10 c0 	movl   $0xc0106ba3,(%esp)
c0103b7e:	e8 91 d1 ff ff       	call   c0100d14 <__panic>
    }
    return &pages[PPN(pa)];
c0103b83:	8b 0d c4 89 11 c0    	mov    0xc01189c4,%ecx
c0103b89:	8b 45 08             	mov    0x8(%ebp),%eax
c0103b8c:	c1 e8 0c             	shr    $0xc,%eax
c0103b8f:	89 c2                	mov    %eax,%edx
c0103b91:	89 d0                	mov    %edx,%eax
c0103b93:	c1 e0 02             	shl    $0x2,%eax
c0103b96:	01 d0                	add    %edx,%eax
c0103b98:	c1 e0 02             	shl    $0x2,%eax
c0103b9b:	01 c8                	add    %ecx,%eax
}
c0103b9d:	c9                   	leave  
c0103b9e:	c3                   	ret    

c0103b9f <page2kva>:

static inline void *
page2kva(struct Page *page) {
c0103b9f:	55                   	push   %ebp
c0103ba0:	89 e5                	mov    %esp,%ebp
c0103ba2:	83 ec 28             	sub    $0x28,%esp
    return KADDR(page2pa(page));
c0103ba5:	8b 45 08             	mov    0x8(%ebp),%eax
c0103ba8:	89 04 24             	mov    %eax,(%esp)
c0103bab:	e8 8a ff ff ff       	call   c0103b3a <page2pa>
c0103bb0:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0103bb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103bb6:	c1 e8 0c             	shr    $0xc,%eax
c0103bb9:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0103bbc:	a1 c0 88 11 c0       	mov    0xc01188c0,%eax
c0103bc1:	39 45 f0             	cmp    %eax,-0x10(%ebp)
c0103bc4:	72 23                	jb     c0103be9 <page2kva+0x4a>
c0103bc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103bc9:	89 44 24 0c          	mov    %eax,0xc(%esp)
c0103bcd:	c7 44 24 08 b4 6b 10 	movl   $0xc0106bb4,0x8(%esp)
c0103bd4:	c0 
c0103bd5:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
c0103bdc:	00 
c0103bdd:	c7 04 24 a3 6b 10 c0 	movl   $0xc0106ba3,(%esp)
c0103be4:	e8 2b d1 ff ff       	call   c0100d14 <__panic>
c0103be9:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103bec:	2d 00 00 00 40       	sub    $0x40000000,%eax
}
c0103bf1:	c9                   	leave  
c0103bf2:	c3                   	ret    

c0103bf3 <pte2page>:
kva2page(void *kva) {
    return pa2page(PADDR(kva));
}

static inline struct Page *
pte2page(pte_t pte) {
c0103bf3:	55                   	push   %ebp
c0103bf4:	89 e5                	mov    %esp,%ebp
c0103bf6:	83 ec 18             	sub    $0x18,%esp
    if (!(pte & PTE_P)) {
c0103bf9:	8b 45 08             	mov    0x8(%ebp),%eax
c0103bfc:	83 e0 01             	and    $0x1,%eax
c0103bff:	85 c0                	test   %eax,%eax
c0103c01:	75 1c                	jne    c0103c1f <pte2page+0x2c>
        panic("pte2page called with invalid pte");
c0103c03:	c7 44 24 08 d8 6b 10 	movl   $0xc0106bd8,0x8(%esp)
c0103c0a:	c0 
c0103c0b:	c7 44 24 04 6c 00 00 	movl   $0x6c,0x4(%esp)
c0103c12:	00 
c0103c13:	c7 04 24 a3 6b 10 c0 	movl   $0xc0106ba3,(%esp)
c0103c1a:	e8 f5 d0 ff ff       	call   c0100d14 <__panic>
    }
    return pa2page(PTE_ADDR(pte));
c0103c1f:	8b 45 08             	mov    0x8(%ebp),%eax
c0103c22:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0103c27:	89 04 24             	mov    %eax,(%esp)
c0103c2a:	e8 21 ff ff ff       	call   c0103b50 <pa2page>
}
c0103c2f:	c9                   	leave  
c0103c30:	c3                   	ret    

c0103c31 <page_ref>:
pde2page(pde_t pde) {
    return pa2page(PDE_ADDR(pde));
}

static inline int
page_ref(struct Page *page) {
c0103c31:	55                   	push   %ebp
c0103c32:	89 e5                	mov    %esp,%ebp
    return page->ref;
c0103c34:	8b 45 08             	mov    0x8(%ebp),%eax
c0103c37:	8b 00                	mov    (%eax),%eax
}
c0103c39:	5d                   	pop    %ebp
c0103c3a:	c3                   	ret    

c0103c3b <set_page_ref>:

static inline void
set_page_ref(struct Page *page, int val) {
c0103c3b:	55                   	push   %ebp
c0103c3c:	89 e5                	mov    %esp,%ebp
    page->ref = val;
c0103c3e:	8b 45 08             	mov    0x8(%ebp),%eax
c0103c41:	8b 55 0c             	mov    0xc(%ebp),%edx
c0103c44:	89 10                	mov    %edx,(%eax)
}
c0103c46:	5d                   	pop    %ebp
c0103c47:	c3                   	ret    

c0103c48 <page_ref_inc>:

static inline int
page_ref_inc(struct Page *page) {
c0103c48:	55                   	push   %ebp
c0103c49:	89 e5                	mov    %esp,%ebp
    page->ref += 1;
c0103c4b:	8b 45 08             	mov    0x8(%ebp),%eax
c0103c4e:	8b 00                	mov    (%eax),%eax
c0103c50:	8d 50 01             	lea    0x1(%eax),%edx
c0103c53:	8b 45 08             	mov    0x8(%ebp),%eax
c0103c56:	89 10                	mov    %edx,(%eax)
    return page->ref;
c0103c58:	8b 45 08             	mov    0x8(%ebp),%eax
c0103c5b:	8b 00                	mov    (%eax),%eax
}
c0103c5d:	5d                   	pop    %ebp
c0103c5e:	c3                   	ret    

c0103c5f <page_ref_dec>:

static inline int
page_ref_dec(struct Page *page) {
c0103c5f:	55                   	push   %ebp
c0103c60:	89 e5                	mov    %esp,%ebp
    page->ref -= 1;
c0103c62:	8b 45 08             	mov    0x8(%ebp),%eax
c0103c65:	8b 00                	mov    (%eax),%eax
c0103c67:	8d 50 ff             	lea    -0x1(%eax),%edx
c0103c6a:	8b 45 08             	mov    0x8(%ebp),%eax
c0103c6d:	89 10                	mov    %edx,(%eax)
    return page->ref;
c0103c6f:	8b 45 08             	mov    0x8(%ebp),%eax
c0103c72:	8b 00                	mov    (%eax),%eax
}
c0103c74:	5d                   	pop    %ebp
c0103c75:	c3                   	ret    

c0103c76 <__intr_save>:
#include <x86.h>
#include <intr.h>
#include <mmu.h>

static inline bool
__intr_save(void) {
c0103c76:	55                   	push   %ebp
c0103c77:	89 e5                	mov    %esp,%ebp
c0103c79:	83 ec 18             	sub    $0x18,%esp
}

static inline uint32_t
read_eflags(void) {
    uint32_t eflags;
    asm volatile ("pushfl; popl %0" : "=r" (eflags));
c0103c7c:	9c                   	pushf  
c0103c7d:	58                   	pop    %eax
c0103c7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return eflags;
c0103c81:	8b 45 f4             	mov    -0xc(%ebp),%eax
    if (read_eflags() & FL_IF) {
c0103c84:	25 00 02 00 00       	and    $0x200,%eax
c0103c89:	85 c0                	test   %eax,%eax
c0103c8b:	74 0c                	je     c0103c99 <__intr_save+0x23>
        intr_disable();
c0103c8d:	e8 65 da ff ff       	call   c01016f7 <intr_disable>
        return 1;
c0103c92:	b8 01 00 00 00       	mov    $0x1,%eax
c0103c97:	eb 05                	jmp    c0103c9e <__intr_save+0x28>
    }
    return 0;
c0103c99:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0103c9e:	c9                   	leave  
c0103c9f:	c3                   	ret    

c0103ca0 <__intr_restore>:

static inline void
__intr_restore(bool flag) {
c0103ca0:	55                   	push   %ebp
c0103ca1:	89 e5                	mov    %esp,%ebp
c0103ca3:	83 ec 08             	sub    $0x8,%esp
    if (flag) {
c0103ca6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0103caa:	74 05                	je     c0103cb1 <__intr_restore+0x11>
        intr_enable();
c0103cac:	e8 40 da ff ff       	call   c01016f1 <intr_enable>
    }
}
c0103cb1:	c9                   	leave  
c0103cb2:	c3                   	ret    

c0103cb3 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
c0103cb3:	55                   	push   %ebp
c0103cb4:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
c0103cb6:	8b 45 08             	mov    0x8(%ebp),%eax
c0103cb9:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
c0103cbc:	b8 23 00 00 00       	mov    $0x23,%eax
c0103cc1:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
c0103cc3:	b8 23 00 00 00       	mov    $0x23,%eax
c0103cc8:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
c0103cca:	b8 10 00 00 00       	mov    $0x10,%eax
c0103ccf:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
c0103cd1:	b8 10 00 00 00       	mov    $0x10,%eax
c0103cd6:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
c0103cd8:	b8 10 00 00 00       	mov    $0x10,%eax
c0103cdd:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
c0103cdf:	ea e6 3c 10 c0 08 00 	ljmp   $0x8,$0xc0103ce6
}
c0103ce6:	5d                   	pop    %ebp
c0103ce7:	c3                   	ret    

c0103ce8 <load_esp0>:
 * load_esp0 - change the ESP0 in default task state segment,
 * so that we can use different kernel stack when we trap frame
 * user to kernel.
 * */
void
load_esp0(uintptr_t esp0) {
c0103ce8:	55                   	push   %ebp
c0103ce9:	89 e5                	mov    %esp,%ebp
    ts.ts_esp0 = esp0;
c0103ceb:	8b 45 08             	mov    0x8(%ebp),%eax
c0103cee:	a3 e4 88 11 c0       	mov    %eax,0xc01188e4
}
c0103cf3:	5d                   	pop    %ebp
c0103cf4:	c3                   	ret    

c0103cf5 <gdt_init>:

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
c0103cf5:	55                   	push   %ebp
c0103cf6:	89 e5                	mov    %esp,%ebp
c0103cf8:	83 ec 14             	sub    $0x14,%esp
    // set boot kernel stack and default SS0
    load_esp0((uintptr_t)bootstacktop);
c0103cfb:	b8 00 70 11 c0       	mov    $0xc0117000,%eax
c0103d00:	89 04 24             	mov    %eax,(%esp)
c0103d03:	e8 e0 ff ff ff       	call   c0103ce8 <load_esp0>
    ts.ts_ss0 = KERNEL_DS;
c0103d08:	66 c7 05 e8 88 11 c0 	movw   $0x10,0xc01188e8
c0103d0f:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEGTSS(STS_T32A, (uintptr_t)&ts, sizeof(ts), DPL_KERNEL);
c0103d11:	66 c7 05 28 7a 11 c0 	movw   $0x68,0xc0117a28
c0103d18:	68 00 
c0103d1a:	b8 e0 88 11 c0       	mov    $0xc01188e0,%eax
c0103d1f:	66 a3 2a 7a 11 c0    	mov    %ax,0xc0117a2a
c0103d25:	b8 e0 88 11 c0       	mov    $0xc01188e0,%eax
c0103d2a:	c1 e8 10             	shr    $0x10,%eax
c0103d2d:	a2 2c 7a 11 c0       	mov    %al,0xc0117a2c
c0103d32:	0f b6 05 2d 7a 11 c0 	movzbl 0xc0117a2d,%eax
c0103d39:	83 e0 f0             	and    $0xfffffff0,%eax
c0103d3c:	83 c8 09             	or     $0x9,%eax
c0103d3f:	a2 2d 7a 11 c0       	mov    %al,0xc0117a2d
c0103d44:	0f b6 05 2d 7a 11 c0 	movzbl 0xc0117a2d,%eax
c0103d4b:	83 e0 ef             	and    $0xffffffef,%eax
c0103d4e:	a2 2d 7a 11 c0       	mov    %al,0xc0117a2d
c0103d53:	0f b6 05 2d 7a 11 c0 	movzbl 0xc0117a2d,%eax
c0103d5a:	83 e0 9f             	and    $0xffffff9f,%eax
c0103d5d:	a2 2d 7a 11 c0       	mov    %al,0xc0117a2d
c0103d62:	0f b6 05 2d 7a 11 c0 	movzbl 0xc0117a2d,%eax
c0103d69:	83 c8 80             	or     $0xffffff80,%eax
c0103d6c:	a2 2d 7a 11 c0       	mov    %al,0xc0117a2d
c0103d71:	0f b6 05 2e 7a 11 c0 	movzbl 0xc0117a2e,%eax
c0103d78:	83 e0 f0             	and    $0xfffffff0,%eax
c0103d7b:	a2 2e 7a 11 c0       	mov    %al,0xc0117a2e
c0103d80:	0f b6 05 2e 7a 11 c0 	movzbl 0xc0117a2e,%eax
c0103d87:	83 e0 ef             	and    $0xffffffef,%eax
c0103d8a:	a2 2e 7a 11 c0       	mov    %al,0xc0117a2e
c0103d8f:	0f b6 05 2e 7a 11 c0 	movzbl 0xc0117a2e,%eax
c0103d96:	83 e0 df             	and    $0xffffffdf,%eax
c0103d99:	a2 2e 7a 11 c0       	mov    %al,0xc0117a2e
c0103d9e:	0f b6 05 2e 7a 11 c0 	movzbl 0xc0117a2e,%eax
c0103da5:	83 c8 40             	or     $0x40,%eax
c0103da8:	a2 2e 7a 11 c0       	mov    %al,0xc0117a2e
c0103dad:	0f b6 05 2e 7a 11 c0 	movzbl 0xc0117a2e,%eax
c0103db4:	83 e0 7f             	and    $0x7f,%eax
c0103db7:	a2 2e 7a 11 c0       	mov    %al,0xc0117a2e
c0103dbc:	b8 e0 88 11 c0       	mov    $0xc01188e0,%eax
c0103dc1:	c1 e8 18             	shr    $0x18,%eax
c0103dc4:	a2 2f 7a 11 c0       	mov    %al,0xc0117a2f

    // reload all segment registers
    lgdt(&gdt_pd);
c0103dc9:	c7 04 24 30 7a 11 c0 	movl   $0xc0117a30,(%esp)
c0103dd0:	e8 de fe ff ff       	call   c0103cb3 <lgdt>
c0103dd5:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
    asm volatile ("cli" ::: "memory");
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel) : "memory");
c0103ddb:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
c0103ddf:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
c0103de2:	c9                   	leave  
c0103de3:	c3                   	ret    

c0103de4 <init_pmm_manager>:

//init_pmm_manager - initialize a pmm_manager instance
static void
init_pmm_manager(void) {
c0103de4:	55                   	push   %ebp
c0103de5:	89 e5                	mov    %esp,%ebp
c0103de7:	83 ec 18             	sub    $0x18,%esp
    pmm_manager = &default_pmm_manager;
c0103dea:	c7 05 bc 89 11 c0 68 	movl   $0xc0106b68,0xc01189bc
c0103df1:	6b 10 c0 
    cprintf("memory management: %s\n", pmm_manager->name);
c0103df4:	a1 bc 89 11 c0       	mov    0xc01189bc,%eax
c0103df9:	8b 00                	mov    (%eax),%eax
c0103dfb:	89 44 24 04          	mov    %eax,0x4(%esp)
c0103dff:	c7 04 24 04 6c 10 c0 	movl   $0xc0106c04,(%esp)
c0103e06:	e8 41 c5 ff ff       	call   c010034c <cprintf>
    pmm_manager->init();
c0103e0b:	a1 bc 89 11 c0       	mov    0xc01189bc,%eax
c0103e10:	8b 40 04             	mov    0x4(%eax),%eax
c0103e13:	ff d0                	call   *%eax
}
c0103e15:	c9                   	leave  
c0103e16:	c3                   	ret    

c0103e17 <init_memmap>:

//init_memmap - call pmm->init_memmap to build Page struct for free memory  
static void
init_memmap(struct Page *base, size_t n) {
c0103e17:	55                   	push   %ebp
c0103e18:	89 e5                	mov    %esp,%ebp
c0103e1a:	83 ec 18             	sub    $0x18,%esp
    pmm_manager->init_memmap(base, n);
c0103e1d:	a1 bc 89 11 c0       	mov    0xc01189bc,%eax
c0103e22:	8b 40 08             	mov    0x8(%eax),%eax
c0103e25:	8b 55 0c             	mov    0xc(%ebp),%edx
c0103e28:	89 54 24 04          	mov    %edx,0x4(%esp)
c0103e2c:	8b 55 08             	mov    0x8(%ebp),%edx
c0103e2f:	89 14 24             	mov    %edx,(%esp)
c0103e32:	ff d0                	call   *%eax
}
c0103e34:	c9                   	leave  
c0103e35:	c3                   	ret    

c0103e36 <alloc_pages>:

//alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE memory 
struct Page *
alloc_pages(size_t n) {
c0103e36:	55                   	push   %ebp
c0103e37:	89 e5                	mov    %esp,%ebp
c0103e39:	83 ec 28             	sub    $0x28,%esp
    struct Page *page=NULL;
c0103e3c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    bool intr_flag;
    local_intr_save(intr_flag);
c0103e43:	e8 2e fe ff ff       	call   c0103c76 <__intr_save>
c0103e48:	89 45 f0             	mov    %eax,-0x10(%ebp)
    {
        page = pmm_manager->alloc_pages(n);
c0103e4b:	a1 bc 89 11 c0       	mov    0xc01189bc,%eax
c0103e50:	8b 40 0c             	mov    0xc(%eax),%eax
c0103e53:	8b 55 08             	mov    0x8(%ebp),%edx
c0103e56:	89 14 24             	mov    %edx,(%esp)
c0103e59:	ff d0                	call   *%eax
c0103e5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    }
    local_intr_restore(intr_flag);
c0103e5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103e61:	89 04 24             	mov    %eax,(%esp)
c0103e64:	e8 37 fe ff ff       	call   c0103ca0 <__intr_restore>
    return page;
c0103e69:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0103e6c:	c9                   	leave  
c0103e6d:	c3                   	ret    

c0103e6e <free_pages>:

//free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory 
void
free_pages(struct Page *base, size_t n) {
c0103e6e:	55                   	push   %ebp
c0103e6f:	89 e5                	mov    %esp,%ebp
c0103e71:	83 ec 28             	sub    $0x28,%esp
    bool intr_flag;
    local_intr_save(intr_flag);
c0103e74:	e8 fd fd ff ff       	call   c0103c76 <__intr_save>
c0103e79:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        pmm_manager->free_pages(base, n);
c0103e7c:	a1 bc 89 11 c0       	mov    0xc01189bc,%eax
c0103e81:	8b 40 10             	mov    0x10(%eax),%eax
c0103e84:	8b 55 0c             	mov    0xc(%ebp),%edx
c0103e87:	89 54 24 04          	mov    %edx,0x4(%esp)
c0103e8b:	8b 55 08             	mov    0x8(%ebp),%edx
c0103e8e:	89 14 24             	mov    %edx,(%esp)
c0103e91:	ff d0                	call   *%eax
    }
    local_intr_restore(intr_flag);
c0103e93:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103e96:	89 04 24             	mov    %eax,(%esp)
c0103e99:	e8 02 fe ff ff       	call   c0103ca0 <__intr_restore>
}
c0103e9e:	c9                   	leave  
c0103e9f:	c3                   	ret    

c0103ea0 <nr_free_pages>:

//nr_free_pages - call pmm->nr_free_pages to get the size (nr*PAGESIZE) 
//of current free memory
size_t
nr_free_pages(void) {
c0103ea0:	55                   	push   %ebp
c0103ea1:	89 e5                	mov    %esp,%ebp
c0103ea3:	83 ec 28             	sub    $0x28,%esp
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
c0103ea6:	e8 cb fd ff ff       	call   c0103c76 <__intr_save>
c0103eab:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        ret = pmm_manager->nr_free_pages();
c0103eae:	a1 bc 89 11 c0       	mov    0xc01189bc,%eax
c0103eb3:	8b 40 14             	mov    0x14(%eax),%eax
c0103eb6:	ff d0                	call   *%eax
c0103eb8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    local_intr_restore(intr_flag);
c0103ebb:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103ebe:	89 04 24             	mov    %eax,(%esp)
c0103ec1:	e8 da fd ff ff       	call   c0103ca0 <__intr_restore>
    return ret;
c0103ec6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
c0103ec9:	c9                   	leave  
c0103eca:	c3                   	ret    

c0103ecb <page_init>:

/* pmm_init - initialize the physical memory management */
static void
page_init(void) {
c0103ecb:	55                   	push   %ebp
c0103ecc:	89 e5                	mov    %esp,%ebp
c0103ece:	57                   	push   %edi
c0103ecf:	56                   	push   %esi
c0103ed0:	53                   	push   %ebx
c0103ed1:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
    struct e820map *memmap = (struct e820map *)(0x8000 + KERNBASE);
c0103ed7:	c7 45 c4 00 80 00 c0 	movl   $0xc0008000,-0x3c(%ebp)
    uint64_t maxpa = 0;
c0103ede:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
c0103ee5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

    cprintf("e820map:\n");
c0103eec:	c7 04 24 1b 6c 10 c0 	movl   $0xc0106c1b,(%esp)
c0103ef3:	e8 54 c4 ff ff       	call   c010034c <cprintf>
    int i;
    for (i = 0; i < memmap->nr_map; i ++) {
c0103ef8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c0103eff:	e9 15 01 00 00       	jmp    c0104019 <page_init+0x14e>
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
c0103f04:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0103f07:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0103f0a:	89 d0                	mov    %edx,%eax
c0103f0c:	c1 e0 02             	shl    $0x2,%eax
c0103f0f:	01 d0                	add    %edx,%eax
c0103f11:	c1 e0 02             	shl    $0x2,%eax
c0103f14:	01 c8                	add    %ecx,%eax
c0103f16:	8b 50 08             	mov    0x8(%eax),%edx
c0103f19:	8b 40 04             	mov    0x4(%eax),%eax
c0103f1c:	89 45 b8             	mov    %eax,-0x48(%ebp)
c0103f1f:	89 55 bc             	mov    %edx,-0x44(%ebp)
c0103f22:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0103f25:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0103f28:	89 d0                	mov    %edx,%eax
c0103f2a:	c1 e0 02             	shl    $0x2,%eax
c0103f2d:	01 d0                	add    %edx,%eax
c0103f2f:	c1 e0 02             	shl    $0x2,%eax
c0103f32:	01 c8                	add    %ecx,%eax
c0103f34:	8b 48 0c             	mov    0xc(%eax),%ecx
c0103f37:	8b 58 10             	mov    0x10(%eax),%ebx
c0103f3a:	8b 45 b8             	mov    -0x48(%ebp),%eax
c0103f3d:	8b 55 bc             	mov    -0x44(%ebp),%edx
c0103f40:	01 c8                	add    %ecx,%eax
c0103f42:	11 da                	adc    %ebx,%edx
c0103f44:	89 45 b0             	mov    %eax,-0x50(%ebp)
c0103f47:	89 55 b4             	mov    %edx,-0x4c(%ebp)
        cprintf("  memory: %08llx, [%08llx, %08llx], type = %d.\n",
c0103f4a:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0103f4d:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0103f50:	89 d0                	mov    %edx,%eax
c0103f52:	c1 e0 02             	shl    $0x2,%eax
c0103f55:	01 d0                	add    %edx,%eax
c0103f57:	c1 e0 02             	shl    $0x2,%eax
c0103f5a:	01 c8                	add    %ecx,%eax
c0103f5c:	83 c0 14             	add    $0x14,%eax
c0103f5f:	8b 00                	mov    (%eax),%eax
c0103f61:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
c0103f67:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0103f6a:	8b 55 b4             	mov    -0x4c(%ebp),%edx
c0103f6d:	83 c0 ff             	add    $0xffffffff,%eax
c0103f70:	83 d2 ff             	adc    $0xffffffff,%edx
c0103f73:	89 c6                	mov    %eax,%esi
c0103f75:	89 d7                	mov    %edx,%edi
c0103f77:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0103f7a:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0103f7d:	89 d0                	mov    %edx,%eax
c0103f7f:	c1 e0 02             	shl    $0x2,%eax
c0103f82:	01 d0                	add    %edx,%eax
c0103f84:	c1 e0 02             	shl    $0x2,%eax
c0103f87:	01 c8                	add    %ecx,%eax
c0103f89:	8b 48 0c             	mov    0xc(%eax),%ecx
c0103f8c:	8b 58 10             	mov    0x10(%eax),%ebx
c0103f8f:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
c0103f95:	89 44 24 1c          	mov    %eax,0x1c(%esp)
c0103f99:	89 74 24 14          	mov    %esi,0x14(%esp)
c0103f9d:	89 7c 24 18          	mov    %edi,0x18(%esp)
c0103fa1:	8b 45 b8             	mov    -0x48(%ebp),%eax
c0103fa4:	8b 55 bc             	mov    -0x44(%ebp),%edx
c0103fa7:	89 44 24 0c          	mov    %eax,0xc(%esp)
c0103fab:	89 54 24 10          	mov    %edx,0x10(%esp)
c0103faf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
c0103fb3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
c0103fb7:	c7 04 24 28 6c 10 c0 	movl   $0xc0106c28,(%esp)
c0103fbe:	e8 89 c3 ff ff       	call   c010034c <cprintf>
                memmap->map[i].size, begin, end - 1, memmap->map[i].type);
        if (memmap->map[i].type == E820_ARM) {
c0103fc3:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0103fc6:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0103fc9:	89 d0                	mov    %edx,%eax
c0103fcb:	c1 e0 02             	shl    $0x2,%eax
c0103fce:	01 d0                	add    %edx,%eax
c0103fd0:	c1 e0 02             	shl    $0x2,%eax
c0103fd3:	01 c8                	add    %ecx,%eax
c0103fd5:	83 c0 14             	add    $0x14,%eax
c0103fd8:	8b 00                	mov    (%eax),%eax
c0103fda:	83 f8 01             	cmp    $0x1,%eax
c0103fdd:	75 36                	jne    c0104015 <page_init+0x14a>
            if (maxpa < end && begin < KMEMSIZE) {
c0103fdf:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0103fe2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0103fe5:	3b 55 b4             	cmp    -0x4c(%ebp),%edx
c0103fe8:	77 2b                	ja     c0104015 <page_init+0x14a>
c0103fea:	3b 55 b4             	cmp    -0x4c(%ebp),%edx
c0103fed:	72 05                	jb     c0103ff4 <page_init+0x129>
c0103fef:	3b 45 b0             	cmp    -0x50(%ebp),%eax
c0103ff2:	73 21                	jae    c0104015 <page_init+0x14a>
c0103ff4:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
c0103ff8:	77 1b                	ja     c0104015 <page_init+0x14a>
c0103ffa:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
c0103ffe:	72 09                	jb     c0104009 <page_init+0x13e>
c0104000:	81 7d b8 ff ff ff 37 	cmpl   $0x37ffffff,-0x48(%ebp)
c0104007:	77 0c                	ja     c0104015 <page_init+0x14a>
                maxpa = end;
c0104009:	8b 45 b0             	mov    -0x50(%ebp),%eax
c010400c:	8b 55 b4             	mov    -0x4c(%ebp),%edx
c010400f:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0104012:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    struct e820map *memmap = (struct e820map *)(0x8000 + KERNBASE);
    uint64_t maxpa = 0;

    cprintf("e820map:\n");
    int i;
    for (i = 0; i < memmap->nr_map; i ++) {
c0104015:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
c0104019:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c010401c:	8b 00                	mov    (%eax),%eax
c010401e:	3b 45 dc             	cmp    -0x24(%ebp),%eax
c0104021:	0f 8f dd fe ff ff    	jg     c0103f04 <page_init+0x39>
            if (maxpa < end && begin < KMEMSIZE) {
                maxpa = end;
            }
        }
    }
    if (maxpa > KMEMSIZE) {
c0104027:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c010402b:	72 1d                	jb     c010404a <page_init+0x17f>
c010402d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c0104031:	77 09                	ja     c010403c <page_init+0x171>
c0104033:	81 7d e0 00 00 00 38 	cmpl   $0x38000000,-0x20(%ebp)
c010403a:	76 0e                	jbe    c010404a <page_init+0x17f>
        maxpa = KMEMSIZE;
c010403c:	c7 45 e0 00 00 00 38 	movl   $0x38000000,-0x20(%ebp)
c0104043:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    }

    extern char end[];

    npage = maxpa / PGSIZE;
c010404a:	8b 45 e0             	mov    -0x20(%ebp),%eax
c010404d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0104050:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
c0104054:	c1 ea 0c             	shr    $0xc,%edx
c0104057:	a3 c0 88 11 c0       	mov    %eax,0xc01188c0
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
c010405c:	c7 45 ac 00 10 00 00 	movl   $0x1000,-0x54(%ebp)
c0104063:	b8 c8 89 11 c0       	mov    $0xc01189c8,%eax
c0104068:	8d 50 ff             	lea    -0x1(%eax),%edx
c010406b:	8b 45 ac             	mov    -0x54(%ebp),%eax
c010406e:	01 d0                	add    %edx,%eax
c0104070:	89 45 a8             	mov    %eax,-0x58(%ebp)
c0104073:	8b 45 a8             	mov    -0x58(%ebp),%eax
c0104076:	ba 00 00 00 00       	mov    $0x0,%edx
c010407b:	f7 75 ac             	divl   -0x54(%ebp)
c010407e:	89 d0                	mov    %edx,%eax
c0104080:	8b 55 a8             	mov    -0x58(%ebp),%edx
c0104083:	29 c2                	sub    %eax,%edx
c0104085:	89 d0                	mov    %edx,%eax
c0104087:	a3 c4 89 11 c0       	mov    %eax,0xc01189c4

    for (i = 0; i < npage; i ++) {
c010408c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c0104093:	eb 2f                	jmp    c01040c4 <page_init+0x1f9>
        SetPageReserved(pages + i);
c0104095:	8b 0d c4 89 11 c0    	mov    0xc01189c4,%ecx
c010409b:	8b 55 dc             	mov    -0x24(%ebp),%edx
c010409e:	89 d0                	mov    %edx,%eax
c01040a0:	c1 e0 02             	shl    $0x2,%eax
c01040a3:	01 d0                	add    %edx,%eax
c01040a5:	c1 e0 02             	shl    $0x2,%eax
c01040a8:	01 c8                	add    %ecx,%eax
c01040aa:	83 c0 04             	add    $0x4,%eax
c01040ad:	c7 45 90 00 00 00 00 	movl   $0x0,-0x70(%ebp)
c01040b4:	89 45 8c             	mov    %eax,-0x74(%ebp)
 * Note that @nr may be almost arbitrarily large; this function is not
 * restricted to acting on a single-word quantity.
 * */
static inline void
set_bit(int nr, volatile void *addr) {
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c01040b7:	8b 45 8c             	mov    -0x74(%ebp),%eax
c01040ba:	8b 55 90             	mov    -0x70(%ebp),%edx
c01040bd:	0f ab 10             	bts    %edx,(%eax)
    extern char end[];

    npage = maxpa / PGSIZE;
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);

    for (i = 0; i < npage; i ++) {
c01040c0:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
c01040c4:	8b 55 dc             	mov    -0x24(%ebp),%edx
c01040c7:	a1 c0 88 11 c0       	mov    0xc01188c0,%eax
c01040cc:	39 c2                	cmp    %eax,%edx
c01040ce:	72 c5                	jb     c0104095 <page_init+0x1ca>
        SetPageReserved(pages + i);
    }

    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * npage);
c01040d0:	8b 15 c0 88 11 c0    	mov    0xc01188c0,%edx
c01040d6:	89 d0                	mov    %edx,%eax
c01040d8:	c1 e0 02             	shl    $0x2,%eax
c01040db:	01 d0                	add    %edx,%eax
c01040dd:	c1 e0 02             	shl    $0x2,%eax
c01040e0:	89 c2                	mov    %eax,%edx
c01040e2:	a1 c4 89 11 c0       	mov    0xc01189c4,%eax
c01040e7:	01 d0                	add    %edx,%eax
c01040e9:	89 45 a4             	mov    %eax,-0x5c(%ebp)
c01040ec:	81 7d a4 ff ff ff bf 	cmpl   $0xbfffffff,-0x5c(%ebp)
c01040f3:	77 23                	ja     c0104118 <page_init+0x24d>
c01040f5:	8b 45 a4             	mov    -0x5c(%ebp),%eax
c01040f8:	89 44 24 0c          	mov    %eax,0xc(%esp)
c01040fc:	c7 44 24 08 58 6c 10 	movl   $0xc0106c58,0x8(%esp)
c0104103:	c0 
c0104104:	c7 44 24 04 db 00 00 	movl   $0xdb,0x4(%esp)
c010410b:	00 
c010410c:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104113:	e8 fc cb ff ff       	call   c0100d14 <__panic>
c0104118:	8b 45 a4             	mov    -0x5c(%ebp),%eax
c010411b:	05 00 00 00 40       	add    $0x40000000,%eax
c0104120:	89 45 a0             	mov    %eax,-0x60(%ebp)

    for (i = 0; i < memmap->nr_map; i ++) {
c0104123:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c010412a:	e9 74 01 00 00       	jmp    c01042a3 <page_init+0x3d8>
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
c010412f:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0104132:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0104135:	89 d0                	mov    %edx,%eax
c0104137:	c1 e0 02             	shl    $0x2,%eax
c010413a:	01 d0                	add    %edx,%eax
c010413c:	c1 e0 02             	shl    $0x2,%eax
c010413f:	01 c8                	add    %ecx,%eax
c0104141:	8b 50 08             	mov    0x8(%eax),%edx
c0104144:	8b 40 04             	mov    0x4(%eax),%eax
c0104147:	89 45 d0             	mov    %eax,-0x30(%ebp)
c010414a:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c010414d:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0104150:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0104153:	89 d0                	mov    %edx,%eax
c0104155:	c1 e0 02             	shl    $0x2,%eax
c0104158:	01 d0                	add    %edx,%eax
c010415a:	c1 e0 02             	shl    $0x2,%eax
c010415d:	01 c8                	add    %ecx,%eax
c010415f:	8b 48 0c             	mov    0xc(%eax),%ecx
c0104162:	8b 58 10             	mov    0x10(%eax),%ebx
c0104165:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0104168:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c010416b:	01 c8                	add    %ecx,%eax
c010416d:	11 da                	adc    %ebx,%edx
c010416f:	89 45 c8             	mov    %eax,-0x38(%ebp)
c0104172:	89 55 cc             	mov    %edx,-0x34(%ebp)
        if (memmap->map[i].type == E820_ARM) {
c0104175:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0104178:	8b 55 dc             	mov    -0x24(%ebp),%edx
c010417b:	89 d0                	mov    %edx,%eax
c010417d:	c1 e0 02             	shl    $0x2,%eax
c0104180:	01 d0                	add    %edx,%eax
c0104182:	c1 e0 02             	shl    $0x2,%eax
c0104185:	01 c8                	add    %ecx,%eax
c0104187:	83 c0 14             	add    $0x14,%eax
c010418a:	8b 00                	mov    (%eax),%eax
c010418c:	83 f8 01             	cmp    $0x1,%eax
c010418f:	0f 85 0a 01 00 00    	jne    c010429f <page_init+0x3d4>
            if (begin < freemem) {
c0104195:	8b 45 a0             	mov    -0x60(%ebp),%eax
c0104198:	ba 00 00 00 00       	mov    $0x0,%edx
c010419d:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
c01041a0:	72 17                	jb     c01041b9 <page_init+0x2ee>
c01041a2:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
c01041a5:	77 05                	ja     c01041ac <page_init+0x2e1>
c01041a7:	3b 45 d0             	cmp    -0x30(%ebp),%eax
c01041aa:	76 0d                	jbe    c01041b9 <page_init+0x2ee>
                begin = freemem;
c01041ac:	8b 45 a0             	mov    -0x60(%ebp),%eax
c01041af:	89 45 d0             	mov    %eax,-0x30(%ebp)
c01041b2:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
            }
            if (end > KMEMSIZE) {
c01041b9:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
c01041bd:	72 1d                	jb     c01041dc <page_init+0x311>
c01041bf:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
c01041c3:	77 09                	ja     c01041ce <page_init+0x303>
c01041c5:	81 7d c8 00 00 00 38 	cmpl   $0x38000000,-0x38(%ebp)
c01041cc:	76 0e                	jbe    c01041dc <page_init+0x311>
                end = KMEMSIZE;
c01041ce:	c7 45 c8 00 00 00 38 	movl   $0x38000000,-0x38(%ebp)
c01041d5:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
            }
            if (begin < end) {
c01041dc:	8b 45 d0             	mov    -0x30(%ebp),%eax
c01041df:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c01041e2:	3b 55 cc             	cmp    -0x34(%ebp),%edx
c01041e5:	0f 87 b4 00 00 00    	ja     c010429f <page_init+0x3d4>
c01041eb:	3b 55 cc             	cmp    -0x34(%ebp),%edx
c01041ee:	72 09                	jb     c01041f9 <page_init+0x32e>
c01041f0:	3b 45 c8             	cmp    -0x38(%ebp),%eax
c01041f3:	0f 83 a6 00 00 00    	jae    c010429f <page_init+0x3d4>
                begin = ROUNDUP(begin, PGSIZE);
c01041f9:	c7 45 9c 00 10 00 00 	movl   $0x1000,-0x64(%ebp)
c0104200:	8b 55 d0             	mov    -0x30(%ebp),%edx
c0104203:	8b 45 9c             	mov    -0x64(%ebp),%eax
c0104206:	01 d0                	add    %edx,%eax
c0104208:	83 e8 01             	sub    $0x1,%eax
c010420b:	89 45 98             	mov    %eax,-0x68(%ebp)
c010420e:	8b 45 98             	mov    -0x68(%ebp),%eax
c0104211:	ba 00 00 00 00       	mov    $0x0,%edx
c0104216:	f7 75 9c             	divl   -0x64(%ebp)
c0104219:	89 d0                	mov    %edx,%eax
c010421b:	8b 55 98             	mov    -0x68(%ebp),%edx
c010421e:	29 c2                	sub    %eax,%edx
c0104220:	89 d0                	mov    %edx,%eax
c0104222:	ba 00 00 00 00       	mov    $0x0,%edx
c0104227:	89 45 d0             	mov    %eax,-0x30(%ebp)
c010422a:	89 55 d4             	mov    %edx,-0x2c(%ebp)
                end = ROUNDDOWN(end, PGSIZE);
c010422d:	8b 45 c8             	mov    -0x38(%ebp),%eax
c0104230:	89 45 94             	mov    %eax,-0x6c(%ebp)
c0104233:	8b 45 94             	mov    -0x6c(%ebp),%eax
c0104236:	ba 00 00 00 00       	mov    $0x0,%edx
c010423b:	89 c7                	mov    %eax,%edi
c010423d:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
c0104243:	89 7d 80             	mov    %edi,-0x80(%ebp)
c0104246:	89 d0                	mov    %edx,%eax
c0104248:	83 e0 00             	and    $0x0,%eax
c010424b:	89 45 84             	mov    %eax,-0x7c(%ebp)
c010424e:	8b 45 80             	mov    -0x80(%ebp),%eax
c0104251:	8b 55 84             	mov    -0x7c(%ebp),%edx
c0104254:	89 45 c8             	mov    %eax,-0x38(%ebp)
c0104257:	89 55 cc             	mov    %edx,-0x34(%ebp)
                if (begin < end) {
c010425a:	8b 45 d0             	mov    -0x30(%ebp),%eax
c010425d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0104260:	3b 55 cc             	cmp    -0x34(%ebp),%edx
c0104263:	77 3a                	ja     c010429f <page_init+0x3d4>
c0104265:	3b 55 cc             	cmp    -0x34(%ebp),%edx
c0104268:	72 05                	jb     c010426f <page_init+0x3a4>
c010426a:	3b 45 c8             	cmp    -0x38(%ebp),%eax
c010426d:	73 30                	jae    c010429f <page_init+0x3d4>
                    init_memmap(pa2page(begin), (end - begin) / PGSIZE);
c010426f:	8b 4d d0             	mov    -0x30(%ebp),%ecx
c0104272:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
c0104275:	8b 45 c8             	mov    -0x38(%ebp),%eax
c0104278:	8b 55 cc             	mov    -0x34(%ebp),%edx
c010427b:	29 c8                	sub    %ecx,%eax
c010427d:	19 da                	sbb    %ebx,%edx
c010427f:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
c0104283:	c1 ea 0c             	shr    $0xc,%edx
c0104286:	89 c3                	mov    %eax,%ebx
c0104288:	8b 45 d0             	mov    -0x30(%ebp),%eax
c010428b:	89 04 24             	mov    %eax,(%esp)
c010428e:	e8 bd f8 ff ff       	call   c0103b50 <pa2page>
c0104293:	89 5c 24 04          	mov    %ebx,0x4(%esp)
c0104297:	89 04 24             	mov    %eax,(%esp)
c010429a:	e8 78 fb ff ff       	call   c0103e17 <init_memmap>
        SetPageReserved(pages + i);
    }

    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * npage);

    for (i = 0; i < memmap->nr_map; i ++) {
c010429f:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
c01042a3:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c01042a6:	8b 00                	mov    (%eax),%eax
c01042a8:	3b 45 dc             	cmp    -0x24(%ebp),%eax
c01042ab:	0f 8f 7e fe ff ff    	jg     c010412f <page_init+0x264>
                    init_memmap(pa2page(begin), (end - begin) / PGSIZE);
                }
            }
        }
    }
}
c01042b1:	81 c4 9c 00 00 00    	add    $0x9c,%esp
c01042b7:	5b                   	pop    %ebx
c01042b8:	5e                   	pop    %esi
c01042b9:	5f                   	pop    %edi
c01042ba:	5d                   	pop    %ebp
c01042bb:	c3                   	ret    

c01042bc <enable_paging>:

static void
enable_paging(void) {
c01042bc:	55                   	push   %ebp
c01042bd:	89 e5                	mov    %esp,%ebp
c01042bf:	83 ec 10             	sub    $0x10,%esp
    lcr3(boot_cr3);
c01042c2:	a1 c0 89 11 c0       	mov    0xc01189c0,%eax
c01042c7:	89 45 f8             	mov    %eax,-0x8(%ebp)
    asm volatile ("mov %0, %%cr0" :: "r" (cr0) : "memory");
}

static inline void
lcr3(uintptr_t cr3) {
    asm volatile ("mov %0, %%cr3" :: "r" (cr3) : "memory");
c01042ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
c01042cd:	0f 22 d8             	mov    %eax,%cr3
}

static inline uintptr_t
rcr0(void) {
    uintptr_t cr0;
    asm volatile ("mov %%cr0, %0" : "=r" (cr0) :: "memory");
c01042d0:	0f 20 c0             	mov    %cr0,%eax
c01042d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return cr0;
c01042d6:	8b 45 f4             	mov    -0xc(%ebp),%eax

    // turn on paging
    uint32_t cr0 = rcr0();
c01042d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    cr0 |= CR0_PE | CR0_PG | CR0_AM | CR0_WP | CR0_NE | CR0_TS | CR0_EM | CR0_MP;
c01042dc:	81 4d fc 2f 00 05 80 	orl    $0x8005002f,-0x4(%ebp)
    cr0 &= ~(CR0_TS | CR0_EM);
c01042e3:	83 65 fc f3          	andl   $0xfffffff3,-0x4(%ebp)
c01042e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01042ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile ("pushl %0; popfl" :: "r" (eflags));
}

static inline void
lcr0(uintptr_t cr0) {
    asm volatile ("mov %0, %%cr0" :: "r" (cr0) : "memory");
c01042ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01042f0:	0f 22 c0             	mov    %eax,%cr0
    lcr0(cr0);
}
c01042f3:	c9                   	leave  
c01042f4:	c3                   	ret    

c01042f5 <boot_map_segment>:
//  la:   linear address of this memory need to map (after x86 segment map)
//  size: memory size
//  pa:   physical address of this memory
//  perm: permission of this memory  
static void
boot_map_segment(pde_t *pgdir, uintptr_t la, size_t size, uintptr_t pa, uint32_t perm) {
c01042f5:	55                   	push   %ebp
c01042f6:	89 e5                	mov    %esp,%ebp
c01042f8:	83 ec 38             	sub    $0x38,%esp
    assert(PGOFF(la) == PGOFF(pa));
c01042fb:	8b 45 14             	mov    0x14(%ebp),%eax
c01042fe:	8b 55 0c             	mov    0xc(%ebp),%edx
c0104301:	31 d0                	xor    %edx,%eax
c0104303:	25 ff 0f 00 00       	and    $0xfff,%eax
c0104308:	85 c0                	test   %eax,%eax
c010430a:	74 24                	je     c0104330 <boot_map_segment+0x3b>
c010430c:	c7 44 24 0c 8a 6c 10 	movl   $0xc0106c8a,0xc(%esp)
c0104313:	c0 
c0104314:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c010431b:	c0 
c010431c:	c7 44 24 04 04 01 00 	movl   $0x104,0x4(%esp)
c0104323:	00 
c0104324:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c010432b:	e8 e4 c9 ff ff       	call   c0100d14 <__panic>
    size_t n = ROUNDUP(size + PGOFF(la), PGSIZE) / PGSIZE;
c0104330:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
c0104337:	8b 45 0c             	mov    0xc(%ebp),%eax
c010433a:	25 ff 0f 00 00       	and    $0xfff,%eax
c010433f:	89 c2                	mov    %eax,%edx
c0104341:	8b 45 10             	mov    0x10(%ebp),%eax
c0104344:	01 c2                	add    %eax,%edx
c0104346:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104349:	01 d0                	add    %edx,%eax
c010434b:	83 e8 01             	sub    $0x1,%eax
c010434e:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0104351:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104354:	ba 00 00 00 00       	mov    $0x0,%edx
c0104359:	f7 75 f0             	divl   -0x10(%ebp)
c010435c:	89 d0                	mov    %edx,%eax
c010435e:	8b 55 ec             	mov    -0x14(%ebp),%edx
c0104361:	29 c2                	sub    %eax,%edx
c0104363:	89 d0                	mov    %edx,%eax
c0104365:	c1 e8 0c             	shr    $0xc,%eax
c0104368:	89 45 f4             	mov    %eax,-0xc(%ebp)
    la = ROUNDDOWN(la, PGSIZE);
c010436b:	8b 45 0c             	mov    0xc(%ebp),%eax
c010436e:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0104371:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104374:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0104379:	89 45 0c             	mov    %eax,0xc(%ebp)
    pa = ROUNDDOWN(pa, PGSIZE);
c010437c:	8b 45 14             	mov    0x14(%ebp),%eax
c010437f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0104382:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104385:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c010438a:	89 45 14             	mov    %eax,0x14(%ebp)
    for (; n > 0; n --, la += PGSIZE, pa += PGSIZE) {
c010438d:	eb 6b                	jmp    c01043fa <boot_map_segment+0x105>
        pte_t *ptep = get_pte(pgdir, la, 1);
c010438f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
c0104396:	00 
c0104397:	8b 45 0c             	mov    0xc(%ebp),%eax
c010439a:	89 44 24 04          	mov    %eax,0x4(%esp)
c010439e:	8b 45 08             	mov    0x8(%ebp),%eax
c01043a1:	89 04 24             	mov    %eax,(%esp)
c01043a4:	e8 cc 01 00 00       	call   c0104575 <get_pte>
c01043a9:	89 45 e0             	mov    %eax,-0x20(%ebp)
        assert(ptep != NULL);
c01043ac:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
c01043b0:	75 24                	jne    c01043d6 <boot_map_segment+0xe1>
c01043b2:	c7 44 24 0c b6 6c 10 	movl   $0xc0106cb6,0xc(%esp)
c01043b9:	c0 
c01043ba:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c01043c1:	c0 
c01043c2:	c7 44 24 04 0a 01 00 	movl   $0x10a,0x4(%esp)
c01043c9:	00 
c01043ca:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c01043d1:	e8 3e c9 ff ff       	call   c0100d14 <__panic>
        *ptep = pa | PTE_P | perm;
c01043d6:	8b 45 18             	mov    0x18(%ebp),%eax
c01043d9:	8b 55 14             	mov    0x14(%ebp),%edx
c01043dc:	09 d0                	or     %edx,%eax
c01043de:	83 c8 01             	or     $0x1,%eax
c01043e1:	89 c2                	mov    %eax,%edx
c01043e3:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01043e6:	89 10                	mov    %edx,(%eax)
boot_map_segment(pde_t *pgdir, uintptr_t la, size_t size, uintptr_t pa, uint32_t perm) {
    assert(PGOFF(la) == PGOFF(pa));
    size_t n = ROUNDUP(size + PGOFF(la), PGSIZE) / PGSIZE;
    la = ROUNDDOWN(la, PGSIZE);
    pa = ROUNDDOWN(pa, PGSIZE);
    for (; n > 0; n --, la += PGSIZE, pa += PGSIZE) {
c01043e8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
c01043ec:	81 45 0c 00 10 00 00 	addl   $0x1000,0xc(%ebp)
c01043f3:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
c01043fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01043fe:	75 8f                	jne    c010438f <boot_map_segment+0x9a>
        pte_t *ptep = get_pte(pgdir, la, 1);
        assert(ptep != NULL);
        *ptep = pa | PTE_P | perm;
    }
}
c0104400:	c9                   	leave  
c0104401:	c3                   	ret    

c0104402 <boot_alloc_page>:

//boot_alloc_page - allocate one page using pmm->alloc_pages(1) 
// return value: the kernel virtual address of this allocated page
//note: this function is used to get the memory for PDT(Page Directory Table)&PT(Page Table)
static void *
boot_alloc_page(void) {
c0104402:	55                   	push   %ebp
c0104403:	89 e5                	mov    %esp,%ebp
c0104405:	83 ec 28             	sub    $0x28,%esp
    struct Page *p = alloc_page();
c0104408:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c010440f:	e8 22 fa ff ff       	call   c0103e36 <alloc_pages>
c0104414:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == NULL) {
c0104417:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c010441b:	75 1c                	jne    c0104439 <boot_alloc_page+0x37>
        panic("boot_alloc_page failed.\n");
c010441d:	c7 44 24 08 c3 6c 10 	movl   $0xc0106cc3,0x8(%esp)
c0104424:	c0 
c0104425:	c7 44 24 04 16 01 00 	movl   $0x116,0x4(%esp)
c010442c:	00 
c010442d:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104434:	e8 db c8 ff ff       	call   c0100d14 <__panic>
    }
    return page2kva(p);
c0104439:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010443c:	89 04 24             	mov    %eax,(%esp)
c010443f:	e8 5b f7 ff ff       	call   c0103b9f <page2kva>
}
c0104444:	c9                   	leave  
c0104445:	c3                   	ret    

c0104446 <pmm_init>:

//pmm_init - setup a pmm to manage physical memory, build PDT&PT to setup paging mechanism 
//         - check the correctness of pmm & paging mechanism, print PDT&PT
void
pmm_init(void) {
c0104446:	55                   	push   %ebp
c0104447:	89 e5                	mov    %esp,%ebp
c0104449:	83 ec 38             	sub    $0x38,%esp
    //We need to alloc/free the physical memory (granularity is 4KB or other size). 
    //So a framework of physical memory manager (struct pmm_manager)is defined in pmm.h
    //First we should init a physical memory manager(pmm) based on the framework.
    //Then pmm can alloc/free the physical memory. 
    //Now the first_fit/best_fit/worst_fit/buddy_system pmm are available.
    init_pmm_manager();
c010444c:	e8 93 f9 ff ff       	call   c0103de4 <init_pmm_manager>

    // detect physical memory space, reserve already used memory,
    // then use pmm->init_memmap to create free page list
    page_init();
c0104451:	e8 75 fa ff ff       	call   c0103ecb <page_init>

    //use pmm->check to verify the correctness of the alloc/free function in a pmm
    check_alloc_page();
c0104456:	e8 74 04 00 00       	call   c01048cf <check_alloc_page>

    // create boot_pgdir, an initial page directory(Page Directory Table, PDT)
    boot_pgdir = boot_alloc_page();
c010445b:	e8 a2 ff ff ff       	call   c0104402 <boot_alloc_page>
c0104460:	a3 c4 88 11 c0       	mov    %eax,0xc01188c4
    memset(boot_pgdir, 0, PGSIZE);
c0104465:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c010446a:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
c0104471:	00 
c0104472:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c0104479:	00 
c010447a:	89 04 24             	mov    %eax,(%esp)
c010447d:	e8 b6 1a 00 00       	call   c0105f38 <memset>
    boot_cr3 = PADDR(boot_pgdir);
c0104482:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104487:	89 45 f4             	mov    %eax,-0xc(%ebp)
c010448a:	81 7d f4 ff ff ff bf 	cmpl   $0xbfffffff,-0xc(%ebp)
c0104491:	77 23                	ja     c01044b6 <pmm_init+0x70>
c0104493:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104496:	89 44 24 0c          	mov    %eax,0xc(%esp)
c010449a:	c7 44 24 08 58 6c 10 	movl   $0xc0106c58,0x8(%esp)
c01044a1:	c0 
c01044a2:	c7 44 24 04 30 01 00 	movl   $0x130,0x4(%esp)
c01044a9:	00 
c01044aa:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c01044b1:	e8 5e c8 ff ff       	call   c0100d14 <__panic>
c01044b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01044b9:	05 00 00 00 40       	add    $0x40000000,%eax
c01044be:	a3 c0 89 11 c0       	mov    %eax,0xc01189c0

    check_pgdir();
c01044c3:	e8 25 04 00 00       	call   c01048ed <check_pgdir>

    static_assert(KERNBASE % PTSIZE == 0 && KERNTOP % PTSIZE == 0);

    // recursively insert boot_pgdir in itself
    // to form a virtual page table at virtual address VPT
    boot_pgdir[PDX(VPT)] = PADDR(boot_pgdir) | PTE_P | PTE_W;
c01044c8:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c01044cd:	8d 90 ac 0f 00 00    	lea    0xfac(%eax),%edx
c01044d3:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c01044d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01044db:	81 7d f0 ff ff ff bf 	cmpl   $0xbfffffff,-0x10(%ebp)
c01044e2:	77 23                	ja     c0104507 <pmm_init+0xc1>
c01044e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01044e7:	89 44 24 0c          	mov    %eax,0xc(%esp)
c01044eb:	c7 44 24 08 58 6c 10 	movl   $0xc0106c58,0x8(%esp)
c01044f2:	c0 
c01044f3:	c7 44 24 04 38 01 00 	movl   $0x138,0x4(%esp)
c01044fa:	00 
c01044fb:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104502:	e8 0d c8 ff ff       	call   c0100d14 <__panic>
c0104507:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010450a:	05 00 00 00 40       	add    $0x40000000,%eax
c010450f:	83 c8 03             	or     $0x3,%eax
c0104512:	89 02                	mov    %eax,(%edx)

    // map all physical memory to linear memory with base linear addr KERNBASE
    //linear_addr KERNBASE~KERNBASE+KMEMSIZE = phy_addr 0~KMEMSIZE
    //But shouldn't use this map until enable_paging() & gdt_init() finished.
    boot_map_segment(boot_pgdir, KERNBASE, KMEMSIZE, 0, PTE_W);
c0104514:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104519:	c7 44 24 10 02 00 00 	movl   $0x2,0x10(%esp)
c0104520:	00 
c0104521:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
c0104528:	00 
c0104529:	c7 44 24 08 00 00 00 	movl   $0x38000000,0x8(%esp)
c0104530:	38 
c0104531:	c7 44 24 04 00 00 00 	movl   $0xc0000000,0x4(%esp)
c0104538:	c0 
c0104539:	89 04 24             	mov    %eax,(%esp)
c010453c:	e8 b4 fd ff ff       	call   c01042f5 <boot_map_segment>

    //temporary map: 
    //virtual_addr 3G~3G+4M = linear_addr 0~4M = linear_addr 3G~3G+4M = phy_addr 0~4M     
    boot_pgdir[0] = boot_pgdir[PDX(KERNBASE)];
c0104541:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104546:	8b 15 c4 88 11 c0    	mov    0xc01188c4,%edx
c010454c:	8b 92 00 0c 00 00    	mov    0xc00(%edx),%edx
c0104552:	89 10                	mov    %edx,(%eax)

    enable_paging();
c0104554:	e8 63 fd ff ff       	call   c01042bc <enable_paging>

    //reload gdt(third time,the last time) to map all physical memory
    //virtual_addr 0~4G=liear_addr 0~4G
    //then set kernel stack(ss:esp) in TSS, setup TSS in gdt, load TSS
    gdt_init();
c0104559:	e8 97 f7 ff ff       	call   c0103cf5 <gdt_init>

    //disable the map of virtual_addr 0~4M
    boot_pgdir[0] = 0;
c010455e:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104563:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    //now the basic virtual memory map(see memalyout.h) is established.
    //check the correctness of the basic virtual memory map.
    check_boot_pgdir();
c0104569:	e8 1a 0a 00 00       	call   c0104f88 <check_boot_pgdir>

    print_pgdir();
c010456e:	e8 a7 0e 00 00       	call   c010541a <print_pgdir>

}
c0104573:	c9                   	leave  
c0104574:	c3                   	ret    

c0104575 <get_pte>:
//  pgdir:  the kernel virtual base address of PDT
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
pte_t *
get_pte(pde_t *pgdir, uintptr_t la, bool create) {
c0104575:	55                   	push   %ebp
c0104576:	89 e5                	mov    %esp,%ebp
c0104578:	83 ec 38             	sub    $0x38,%esp
    }
    return NULL;          // (8) return page table entry
#endif

    // get the page directory entry.
    pde_t *pdep = pgdir + PDX(la);
c010457b:	8b 45 0c             	mov    0xc(%ebp),%eax
c010457e:	c1 e8 16             	shr    $0x16,%eax
c0104581:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0104588:	8b 45 08             	mov    0x8(%ebp),%eax
c010458b:	01 d0                	add    %edx,%eax
c010458d:	89 45 f4             	mov    %eax,-0xc(%ebp)

	if (!(*pdep & PTE_P)) //if it's not present, create a page table for it.
c0104590:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104593:	8b 00                	mov    (%eax),%eax
c0104595:	83 e0 01             	and    $0x1,%eax
c0104598:	85 c0                	test   %eax,%eax
c010459a:	0f 85 af 00 00 00    	jne    c010464f <get_pte+0xda>
	{
		struct Page *page;
		if (!create || (page = alloc_page()) == NULL)
c01045a0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c01045a4:	74 15                	je     c01045bb <get_pte+0x46>
c01045a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c01045ad:	e8 84 f8 ff ff       	call   c0103e36 <alloc_pages>
c01045b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01045b5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c01045b9:	75 0a                	jne    c01045c5 <get_pte+0x50>
			return NULL;
c01045bb:	b8 00 00 00 00       	mov    $0x0,%eax
c01045c0:	e9 ef 00 00 00       	jmp    c01046b4 <get_pte+0x13f>

		set_page_ref(page, 1);
c01045c5:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c01045cc:	00 
c01045cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01045d0:	89 04 24             	mov    %eax,(%esp)
c01045d3:	e8 63 f6 ff ff       	call   c0103c3b <set_page_ref>
		uintptr_t pa = page2pa(page);
c01045d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01045db:	89 04 24             	mov    %eax,(%esp)
c01045de:	e8 57 f5 ff ff       	call   c0103b3a <page2pa>
c01045e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
		memset(KADDR(pa), 0, PGSIZE);
c01045e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01045e9:	89 45 e8             	mov    %eax,-0x18(%ebp)
c01045ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01045ef:	c1 e8 0c             	shr    $0xc,%eax
c01045f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c01045f5:	a1 c0 88 11 c0       	mov    0xc01188c0,%eax
c01045fa:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
c01045fd:	72 23                	jb     c0104622 <get_pte+0xad>
c01045ff:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104602:	89 44 24 0c          	mov    %eax,0xc(%esp)
c0104606:	c7 44 24 08 b4 6b 10 	movl   $0xc0106bb4,0x8(%esp)
c010460d:	c0 
c010460e:	c7 44 24 04 8b 01 00 	movl   $0x18b,0x4(%esp)
c0104615:	00 
c0104616:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c010461d:	e8 f2 c6 ff ff       	call   c0100d14 <__panic>
c0104622:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104625:	2d 00 00 00 40       	sub    $0x40000000,%eax
c010462a:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
c0104631:	00 
c0104632:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c0104639:	00 
c010463a:	89 04 24             	mov    %eax,(%esp)
c010463d:	e8 f6 18 00 00       	call   c0105f38 <memset>

		*pdep= pa | PTE_P | PTE_W | PTE_U;
c0104642:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104645:	83 c8 07             	or     $0x7,%eax
c0104648:	89 c2                	mov    %eax,%edx
c010464a:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010464d:	89 10                	mov    %edx,(%eax)
	}

	// get the page table base address.
	pte_t *pt_base= (pte_t *)KADDR(PDE_ADDR(*pdep));
c010464f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104652:	8b 00                	mov    (%eax),%eax
c0104654:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0104659:	89 45 e0             	mov    %eax,-0x20(%ebp)
c010465c:	8b 45 e0             	mov    -0x20(%ebp),%eax
c010465f:	c1 e8 0c             	shr    $0xc,%eax
c0104662:	89 45 dc             	mov    %eax,-0x24(%ebp)
c0104665:	a1 c0 88 11 c0       	mov    0xc01188c0,%eax
c010466a:	39 45 dc             	cmp    %eax,-0x24(%ebp)
c010466d:	72 23                	jb     c0104692 <get_pte+0x11d>
c010466f:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0104672:	89 44 24 0c          	mov    %eax,0xc(%esp)
c0104676:	c7 44 24 08 b4 6b 10 	movl   $0xc0106bb4,0x8(%esp)
c010467d:	c0 
c010467e:	c7 44 24 04 91 01 00 	movl   $0x191,0x4(%esp)
c0104685:	00 
c0104686:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c010468d:	e8 82 c6 ff ff       	call   c0100d14 <__panic>
c0104692:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0104695:	2d 00 00 00 40       	sub    $0x40000000,%eax
c010469a:	89 45 d8             	mov    %eax,-0x28(%ebp)

	// return the page table entry.
	return pt_base + PTX(la);
c010469d:	8b 45 0c             	mov    0xc(%ebp),%eax
c01046a0:	c1 e8 0c             	shr    $0xc,%eax
c01046a3:	25 ff 03 00 00       	and    $0x3ff,%eax
c01046a8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c01046af:	8b 45 d8             	mov    -0x28(%ebp),%eax
c01046b2:	01 d0                	add    %edx,%eax
}
c01046b4:	c9                   	leave  
c01046b5:	c3                   	ret    

c01046b6 <get_page>:

//get_page - get related Page struct for linear address la using PDT pgdir
struct Page *
get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store) {
c01046b6:	55                   	push   %ebp
c01046b7:	89 e5                	mov    %esp,%ebp
c01046b9:	83 ec 28             	sub    $0x28,%esp
    pte_t *ptep = get_pte(pgdir, la, 0);
c01046bc:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c01046c3:	00 
c01046c4:	8b 45 0c             	mov    0xc(%ebp),%eax
c01046c7:	89 44 24 04          	mov    %eax,0x4(%esp)
c01046cb:	8b 45 08             	mov    0x8(%ebp),%eax
c01046ce:	89 04 24             	mov    %eax,(%esp)
c01046d1:	e8 9f fe ff ff       	call   c0104575 <get_pte>
c01046d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep_store != NULL) {
c01046d9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c01046dd:	74 08                	je     c01046e7 <get_page+0x31>
        *ptep_store = ptep;
c01046df:	8b 45 10             	mov    0x10(%ebp),%eax
c01046e2:	8b 55 f4             	mov    -0xc(%ebp),%edx
c01046e5:	89 10                	mov    %edx,(%eax)
    }
    if (ptep != NULL && *ptep & PTE_P) {
c01046e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01046eb:	74 1b                	je     c0104708 <get_page+0x52>
c01046ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01046f0:	8b 00                	mov    (%eax),%eax
c01046f2:	83 e0 01             	and    $0x1,%eax
c01046f5:	85 c0                	test   %eax,%eax
c01046f7:	74 0f                	je     c0104708 <get_page+0x52>
        return pa2page(*ptep);
c01046f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01046fc:	8b 00                	mov    (%eax),%eax
c01046fe:	89 04 24             	mov    %eax,(%esp)
c0104701:	e8 4a f4 ff ff       	call   c0103b50 <pa2page>
c0104706:	eb 05                	jmp    c010470d <get_page+0x57>
    }
    return NULL;
c0104708:	b8 00 00 00 00       	mov    $0x0,%eax
}
c010470d:	c9                   	leave  
c010470e:	c3                   	ret    

c010470f <page_remove_pte>:

//page_remove_pte - free an Page sturct which is related linear address la
//                - and clean(invalidate) pte which is related linear address la
//note: PT is changed, so the TLB need to be invalidate 
static inline void
page_remove_pte(pde_t *pgdir, uintptr_t la, pte_t *ptep) {
c010470f:	55                   	push   %ebp
c0104710:	89 e5                	mov    %esp,%ebp
c0104712:	83 ec 28             	sub    $0x28,%esp
                                  //(5) clear second page table entry
                                  //(6) flush tlb
    }
#endif

    if (*ptep & PTE_P) //check if this page table entry is present
c0104715:	8b 45 10             	mov    0x10(%ebp),%eax
c0104718:	8b 00                	mov    (%eax),%eax
c010471a:	83 e0 01             	and    $0x1,%eax
c010471d:	85 c0                	test   %eax,%eax
c010471f:	74 52                	je     c0104773 <page_remove_pte+0x64>
    {
    	struct Page *page= pte2page(*ptep); //find corresponding page to pte
c0104721:	8b 45 10             	mov    0x10(%ebp),%eax
c0104724:	8b 00                	mov    (%eax),%eax
c0104726:	89 04 24             	mov    %eax,(%esp)
c0104729:	e8 c5 f4 ff ff       	call   c0103bf3 <pte2page>
c010472e:	89 45 f4             	mov    %eax,-0xc(%ebp)

    	page_ref_dec(page); //decrease page reference
c0104731:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104734:	89 04 24             	mov    %eax,(%esp)
c0104737:	e8 23 f5 ff ff       	call   c0103c5f <page_ref_dec>
    	if (page->ref == 0) //free this page when page reference reachs 0
c010473c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010473f:	8b 00                	mov    (%eax),%eax
c0104741:	85 c0                	test   %eax,%eax
c0104743:	75 13                	jne    c0104758 <page_remove_pte+0x49>
    		free_page(page);
c0104745:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c010474c:	00 
c010474d:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104750:	89 04 24             	mov    %eax,(%esp)
c0104753:	e8 16 f7 ff ff       	call   c0103e6e <free_pages>

    	*ptep = 0; //clear second page table entry
c0104758:	8b 45 10             	mov    0x10(%ebp),%eax
c010475b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    	tlb_invalidate(pgdir, la); //flush tlb
c0104761:	8b 45 0c             	mov    0xc(%ebp),%eax
c0104764:	89 44 24 04          	mov    %eax,0x4(%esp)
c0104768:	8b 45 08             	mov    0x8(%ebp),%eax
c010476b:	89 04 24             	mov    %eax,(%esp)
c010476e:	e8 ff 00 00 00       	call   c0104872 <tlb_invalidate>
    }
}
c0104773:	c9                   	leave  
c0104774:	c3                   	ret    

c0104775 <page_remove>:

//page_remove - free an Page which is related linear address la and has an validated pte
void
page_remove(pde_t *pgdir, uintptr_t la) {
c0104775:	55                   	push   %ebp
c0104776:	89 e5                	mov    %esp,%ebp
c0104778:	83 ec 28             	sub    $0x28,%esp
    pte_t *ptep = get_pte(pgdir, la, 0);
c010477b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c0104782:	00 
c0104783:	8b 45 0c             	mov    0xc(%ebp),%eax
c0104786:	89 44 24 04          	mov    %eax,0x4(%esp)
c010478a:	8b 45 08             	mov    0x8(%ebp),%eax
c010478d:	89 04 24             	mov    %eax,(%esp)
c0104790:	e8 e0 fd ff ff       	call   c0104575 <get_pte>
c0104795:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep != NULL) {
c0104798:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c010479c:	74 19                	je     c01047b7 <page_remove+0x42>
        page_remove_pte(pgdir, la, ptep);
c010479e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01047a1:	89 44 24 08          	mov    %eax,0x8(%esp)
c01047a5:	8b 45 0c             	mov    0xc(%ebp),%eax
c01047a8:	89 44 24 04          	mov    %eax,0x4(%esp)
c01047ac:	8b 45 08             	mov    0x8(%ebp),%eax
c01047af:	89 04 24             	mov    %eax,(%esp)
c01047b2:	e8 58 ff ff ff       	call   c010470f <page_remove_pte>
    }
}
c01047b7:	c9                   	leave  
c01047b8:	c3                   	ret    

c01047b9 <page_insert>:
//  la:    the linear address need to map
//  perm:  the permission of this Page which is setted in related pte
// return value: always 0
//note: PT is changed, so the TLB need to be invalidate 
int
page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
c01047b9:	55                   	push   %ebp
c01047ba:	89 e5                	mov    %esp,%ebp
c01047bc:	83 ec 28             	sub    $0x28,%esp
    pte_t *ptep = get_pte(pgdir, la, 1);
c01047bf:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
c01047c6:	00 
c01047c7:	8b 45 10             	mov    0x10(%ebp),%eax
c01047ca:	89 44 24 04          	mov    %eax,0x4(%esp)
c01047ce:	8b 45 08             	mov    0x8(%ebp),%eax
c01047d1:	89 04 24             	mov    %eax,(%esp)
c01047d4:	e8 9c fd ff ff       	call   c0104575 <get_pte>
c01047d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep == NULL) {
c01047dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01047e0:	75 0a                	jne    c01047ec <page_insert+0x33>
        return -E_NO_MEM;
c01047e2:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
c01047e7:	e9 84 00 00 00       	jmp    c0104870 <page_insert+0xb7>
    }
    page_ref_inc(page);
c01047ec:	8b 45 0c             	mov    0xc(%ebp),%eax
c01047ef:	89 04 24             	mov    %eax,(%esp)
c01047f2:	e8 51 f4 ff ff       	call   c0103c48 <page_ref_inc>
    if (*ptep & PTE_P) {
c01047f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01047fa:	8b 00                	mov    (%eax),%eax
c01047fc:	83 e0 01             	and    $0x1,%eax
c01047ff:	85 c0                	test   %eax,%eax
c0104801:	74 3e                	je     c0104841 <page_insert+0x88>
        struct Page *p = pte2page(*ptep);
c0104803:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104806:	8b 00                	mov    (%eax),%eax
c0104808:	89 04 24             	mov    %eax,(%esp)
c010480b:	e8 e3 f3 ff ff       	call   c0103bf3 <pte2page>
c0104810:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (p == page) {
c0104813:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104816:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0104819:	75 0d                	jne    c0104828 <page_insert+0x6f>
            page_ref_dec(page);
c010481b:	8b 45 0c             	mov    0xc(%ebp),%eax
c010481e:	89 04 24             	mov    %eax,(%esp)
c0104821:	e8 39 f4 ff ff       	call   c0103c5f <page_ref_dec>
c0104826:	eb 19                	jmp    c0104841 <page_insert+0x88>
        }
        else {
            page_remove_pte(pgdir, la, ptep);
c0104828:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010482b:	89 44 24 08          	mov    %eax,0x8(%esp)
c010482f:	8b 45 10             	mov    0x10(%ebp),%eax
c0104832:	89 44 24 04          	mov    %eax,0x4(%esp)
c0104836:	8b 45 08             	mov    0x8(%ebp),%eax
c0104839:	89 04 24             	mov    %eax,(%esp)
c010483c:	e8 ce fe ff ff       	call   c010470f <page_remove_pte>
        }
    }
    *ptep = page2pa(page) | PTE_P | perm;
c0104841:	8b 45 0c             	mov    0xc(%ebp),%eax
c0104844:	89 04 24             	mov    %eax,(%esp)
c0104847:	e8 ee f2 ff ff       	call   c0103b3a <page2pa>
c010484c:	0b 45 14             	or     0x14(%ebp),%eax
c010484f:	83 c8 01             	or     $0x1,%eax
c0104852:	89 c2                	mov    %eax,%edx
c0104854:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104857:	89 10                	mov    %edx,(%eax)
    tlb_invalidate(pgdir, la);
c0104859:	8b 45 10             	mov    0x10(%ebp),%eax
c010485c:	89 44 24 04          	mov    %eax,0x4(%esp)
c0104860:	8b 45 08             	mov    0x8(%ebp),%eax
c0104863:	89 04 24             	mov    %eax,(%esp)
c0104866:	e8 07 00 00 00       	call   c0104872 <tlb_invalidate>
    return 0;
c010486b:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0104870:	c9                   	leave  
c0104871:	c3                   	ret    

c0104872 <tlb_invalidate>:

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void
tlb_invalidate(pde_t *pgdir, uintptr_t la) {
c0104872:	55                   	push   %ebp
c0104873:	89 e5                	mov    %esp,%ebp
c0104875:	83 ec 28             	sub    $0x28,%esp
}

static inline uintptr_t
rcr3(void) {
    uintptr_t cr3;
    asm volatile ("mov %%cr3, %0" : "=r" (cr3) :: "memory");
c0104878:	0f 20 d8             	mov    %cr3,%eax
c010487b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    return cr3;
c010487e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    if (rcr3() == PADDR(pgdir)) {
c0104881:	89 c2                	mov    %eax,%edx
c0104883:	8b 45 08             	mov    0x8(%ebp),%eax
c0104886:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0104889:	81 7d f4 ff ff ff bf 	cmpl   $0xbfffffff,-0xc(%ebp)
c0104890:	77 23                	ja     c01048b5 <tlb_invalidate+0x43>
c0104892:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104895:	89 44 24 0c          	mov    %eax,0xc(%esp)
c0104899:	c7 44 24 08 58 6c 10 	movl   $0xc0106c58,0x8(%esp)
c01048a0:	c0 
c01048a1:	c7 44 24 04 fa 01 00 	movl   $0x1fa,0x4(%esp)
c01048a8:	00 
c01048a9:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c01048b0:	e8 5f c4 ff ff       	call   c0100d14 <__panic>
c01048b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01048b8:	05 00 00 00 40       	add    $0x40000000,%eax
c01048bd:	39 c2                	cmp    %eax,%edx
c01048bf:	75 0c                	jne    c01048cd <tlb_invalidate+0x5b>
        invlpg((void *)la);
c01048c1:	8b 45 0c             	mov    0xc(%ebp),%eax
c01048c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
}

static inline void
invlpg(void *addr) {
    asm volatile ("invlpg (%0)" :: "r" (addr) : "memory");
c01048c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01048ca:	0f 01 38             	invlpg (%eax)
    }
}
c01048cd:	c9                   	leave  
c01048ce:	c3                   	ret    

c01048cf <check_alloc_page>:

static void
check_alloc_page(void) {
c01048cf:	55                   	push   %ebp
c01048d0:	89 e5                	mov    %esp,%ebp
c01048d2:	83 ec 18             	sub    $0x18,%esp
    pmm_manager->check();
c01048d5:	a1 bc 89 11 c0       	mov    0xc01189bc,%eax
c01048da:	8b 40 18             	mov    0x18(%eax),%eax
c01048dd:	ff d0                	call   *%eax
    cprintf("check_alloc_page() succeeded!\n");
c01048df:	c7 04 24 dc 6c 10 c0 	movl   $0xc0106cdc,(%esp)
c01048e6:	e8 61 ba ff ff       	call   c010034c <cprintf>
}
c01048eb:	c9                   	leave  
c01048ec:	c3                   	ret    

c01048ed <check_pgdir>:

static void
check_pgdir(void) {
c01048ed:	55                   	push   %ebp
c01048ee:	89 e5                	mov    %esp,%ebp
c01048f0:	83 ec 38             	sub    $0x38,%esp
    assert(npage <= KMEMSIZE / PGSIZE);
c01048f3:	a1 c0 88 11 c0       	mov    0xc01188c0,%eax
c01048f8:	3d 00 80 03 00       	cmp    $0x38000,%eax
c01048fd:	76 24                	jbe    c0104923 <check_pgdir+0x36>
c01048ff:	c7 44 24 0c fb 6c 10 	movl   $0xc0106cfb,0xc(%esp)
c0104906:	c0 
c0104907:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c010490e:	c0 
c010490f:	c7 44 24 04 07 02 00 	movl   $0x207,0x4(%esp)
c0104916:	00 
c0104917:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c010491e:	e8 f1 c3 ff ff       	call   c0100d14 <__panic>
    assert(boot_pgdir != NULL && (uint32_t)PGOFF(boot_pgdir) == 0);
c0104923:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104928:	85 c0                	test   %eax,%eax
c010492a:	74 0e                	je     c010493a <check_pgdir+0x4d>
c010492c:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104931:	25 ff 0f 00 00       	and    $0xfff,%eax
c0104936:	85 c0                	test   %eax,%eax
c0104938:	74 24                	je     c010495e <check_pgdir+0x71>
c010493a:	c7 44 24 0c 18 6d 10 	movl   $0xc0106d18,0xc(%esp)
c0104941:	c0 
c0104942:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104949:	c0 
c010494a:	c7 44 24 04 08 02 00 	movl   $0x208,0x4(%esp)
c0104951:	00 
c0104952:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104959:	e8 b6 c3 ff ff       	call   c0100d14 <__panic>
    assert(get_page(boot_pgdir, 0x0, NULL) == NULL);
c010495e:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104963:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c010496a:	00 
c010496b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c0104972:	00 
c0104973:	89 04 24             	mov    %eax,(%esp)
c0104976:	e8 3b fd ff ff       	call   c01046b6 <get_page>
c010497b:	85 c0                	test   %eax,%eax
c010497d:	74 24                	je     c01049a3 <check_pgdir+0xb6>
c010497f:	c7 44 24 0c 50 6d 10 	movl   $0xc0106d50,0xc(%esp)
c0104986:	c0 
c0104987:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c010498e:	c0 
c010498f:	c7 44 24 04 09 02 00 	movl   $0x209,0x4(%esp)
c0104996:	00 
c0104997:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c010499e:	e8 71 c3 ff ff       	call   c0100d14 <__panic>

    struct Page *p1, *p2;
    p1 = alloc_page();
c01049a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c01049aa:	e8 87 f4 ff ff       	call   c0103e36 <alloc_pages>
c01049af:	89 45 f4             	mov    %eax,-0xc(%ebp)
    assert(page_insert(boot_pgdir, p1, 0x0, 0) == 0);
c01049b2:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c01049b7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
c01049be:	00 
c01049bf:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c01049c6:	00 
c01049c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
c01049ca:	89 54 24 04          	mov    %edx,0x4(%esp)
c01049ce:	89 04 24             	mov    %eax,(%esp)
c01049d1:	e8 e3 fd ff ff       	call   c01047b9 <page_insert>
c01049d6:	85 c0                	test   %eax,%eax
c01049d8:	74 24                	je     c01049fe <check_pgdir+0x111>
c01049da:	c7 44 24 0c 78 6d 10 	movl   $0xc0106d78,0xc(%esp)
c01049e1:	c0 
c01049e2:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c01049e9:	c0 
c01049ea:	c7 44 24 04 0d 02 00 	movl   $0x20d,0x4(%esp)
c01049f1:	00 
c01049f2:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c01049f9:	e8 16 c3 ff ff       	call   c0100d14 <__panic>

    pte_t *ptep;
    assert((ptep = get_pte(boot_pgdir, 0x0, 0)) != NULL);
c01049fe:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104a03:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c0104a0a:	00 
c0104a0b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c0104a12:	00 
c0104a13:	89 04 24             	mov    %eax,(%esp)
c0104a16:	e8 5a fb ff ff       	call   c0104575 <get_pte>
c0104a1b:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0104a1e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0104a22:	75 24                	jne    c0104a48 <check_pgdir+0x15b>
c0104a24:	c7 44 24 0c a4 6d 10 	movl   $0xc0106da4,0xc(%esp)
c0104a2b:	c0 
c0104a2c:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104a33:	c0 
c0104a34:	c7 44 24 04 10 02 00 	movl   $0x210,0x4(%esp)
c0104a3b:	00 
c0104a3c:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104a43:	e8 cc c2 ff ff       	call   c0100d14 <__panic>
    assert(pa2page(*ptep) == p1);
c0104a48:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104a4b:	8b 00                	mov    (%eax),%eax
c0104a4d:	89 04 24             	mov    %eax,(%esp)
c0104a50:	e8 fb f0 ff ff       	call   c0103b50 <pa2page>
c0104a55:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c0104a58:	74 24                	je     c0104a7e <check_pgdir+0x191>
c0104a5a:	c7 44 24 0c d1 6d 10 	movl   $0xc0106dd1,0xc(%esp)
c0104a61:	c0 
c0104a62:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104a69:	c0 
c0104a6a:	c7 44 24 04 11 02 00 	movl   $0x211,0x4(%esp)
c0104a71:	00 
c0104a72:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104a79:	e8 96 c2 ff ff       	call   c0100d14 <__panic>
    assert(page_ref(p1) == 1);
c0104a7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104a81:	89 04 24             	mov    %eax,(%esp)
c0104a84:	e8 a8 f1 ff ff       	call   c0103c31 <page_ref>
c0104a89:	83 f8 01             	cmp    $0x1,%eax
c0104a8c:	74 24                	je     c0104ab2 <check_pgdir+0x1c5>
c0104a8e:	c7 44 24 0c e6 6d 10 	movl   $0xc0106de6,0xc(%esp)
c0104a95:	c0 
c0104a96:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104a9d:	c0 
c0104a9e:	c7 44 24 04 12 02 00 	movl   $0x212,0x4(%esp)
c0104aa5:	00 
c0104aa6:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104aad:	e8 62 c2 ff ff       	call   c0100d14 <__panic>

    ptep = &((pte_t *)KADDR(PDE_ADDR(boot_pgdir[0])))[1];
c0104ab2:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104ab7:	8b 00                	mov    (%eax),%eax
c0104ab9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0104abe:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0104ac1:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104ac4:	c1 e8 0c             	shr    $0xc,%eax
c0104ac7:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0104aca:	a1 c0 88 11 c0       	mov    0xc01188c0,%eax
c0104acf:	39 45 e8             	cmp    %eax,-0x18(%ebp)
c0104ad2:	72 23                	jb     c0104af7 <check_pgdir+0x20a>
c0104ad4:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104ad7:	89 44 24 0c          	mov    %eax,0xc(%esp)
c0104adb:	c7 44 24 08 b4 6b 10 	movl   $0xc0106bb4,0x8(%esp)
c0104ae2:	c0 
c0104ae3:	c7 44 24 04 14 02 00 	movl   $0x214,0x4(%esp)
c0104aea:	00 
c0104aeb:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104af2:	e8 1d c2 ff ff       	call   c0100d14 <__panic>
c0104af7:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104afa:	2d 00 00 00 40       	sub    $0x40000000,%eax
c0104aff:	83 c0 04             	add    $0x4,%eax
c0104b02:	89 45 f0             	mov    %eax,-0x10(%ebp)
    assert(get_pte(boot_pgdir, PGSIZE, 0) == ptep);
c0104b05:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104b0a:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c0104b11:	00 
c0104b12:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
c0104b19:	00 
c0104b1a:	89 04 24             	mov    %eax,(%esp)
c0104b1d:	e8 53 fa ff ff       	call   c0104575 <get_pte>
c0104b22:	3b 45 f0             	cmp    -0x10(%ebp),%eax
c0104b25:	74 24                	je     c0104b4b <check_pgdir+0x25e>
c0104b27:	c7 44 24 0c f8 6d 10 	movl   $0xc0106df8,0xc(%esp)
c0104b2e:	c0 
c0104b2f:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104b36:	c0 
c0104b37:	c7 44 24 04 15 02 00 	movl   $0x215,0x4(%esp)
c0104b3e:	00 
c0104b3f:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104b46:	e8 c9 c1 ff ff       	call   c0100d14 <__panic>

    p2 = alloc_page();
c0104b4b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0104b52:	e8 df f2 ff ff       	call   c0103e36 <alloc_pages>
c0104b57:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    assert(page_insert(boot_pgdir, p2, PGSIZE, PTE_U | PTE_W) == 0);
c0104b5a:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104b5f:	c7 44 24 0c 06 00 00 	movl   $0x6,0xc(%esp)
c0104b66:	00 
c0104b67:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
c0104b6e:	00 
c0104b6f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0104b72:	89 54 24 04          	mov    %edx,0x4(%esp)
c0104b76:	89 04 24             	mov    %eax,(%esp)
c0104b79:	e8 3b fc ff ff       	call   c01047b9 <page_insert>
c0104b7e:	85 c0                	test   %eax,%eax
c0104b80:	74 24                	je     c0104ba6 <check_pgdir+0x2b9>
c0104b82:	c7 44 24 0c 20 6e 10 	movl   $0xc0106e20,0xc(%esp)
c0104b89:	c0 
c0104b8a:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104b91:	c0 
c0104b92:	c7 44 24 04 18 02 00 	movl   $0x218,0x4(%esp)
c0104b99:	00 
c0104b9a:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104ba1:	e8 6e c1 ff ff       	call   c0100d14 <__panic>
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
c0104ba6:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104bab:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c0104bb2:	00 
c0104bb3:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
c0104bba:	00 
c0104bbb:	89 04 24             	mov    %eax,(%esp)
c0104bbe:	e8 b2 f9 ff ff       	call   c0104575 <get_pte>
c0104bc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0104bc6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0104bca:	75 24                	jne    c0104bf0 <check_pgdir+0x303>
c0104bcc:	c7 44 24 0c 58 6e 10 	movl   $0xc0106e58,0xc(%esp)
c0104bd3:	c0 
c0104bd4:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104bdb:	c0 
c0104bdc:	c7 44 24 04 19 02 00 	movl   $0x219,0x4(%esp)
c0104be3:	00 
c0104be4:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104beb:	e8 24 c1 ff ff       	call   c0100d14 <__panic>
    assert(*ptep & PTE_U);
c0104bf0:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104bf3:	8b 00                	mov    (%eax),%eax
c0104bf5:	83 e0 04             	and    $0x4,%eax
c0104bf8:	85 c0                	test   %eax,%eax
c0104bfa:	75 24                	jne    c0104c20 <check_pgdir+0x333>
c0104bfc:	c7 44 24 0c 88 6e 10 	movl   $0xc0106e88,0xc(%esp)
c0104c03:	c0 
c0104c04:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104c0b:	c0 
c0104c0c:	c7 44 24 04 1a 02 00 	movl   $0x21a,0x4(%esp)
c0104c13:	00 
c0104c14:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104c1b:	e8 f4 c0 ff ff       	call   c0100d14 <__panic>
    assert(*ptep & PTE_W);
c0104c20:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104c23:	8b 00                	mov    (%eax),%eax
c0104c25:	83 e0 02             	and    $0x2,%eax
c0104c28:	85 c0                	test   %eax,%eax
c0104c2a:	75 24                	jne    c0104c50 <check_pgdir+0x363>
c0104c2c:	c7 44 24 0c 96 6e 10 	movl   $0xc0106e96,0xc(%esp)
c0104c33:	c0 
c0104c34:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104c3b:	c0 
c0104c3c:	c7 44 24 04 1b 02 00 	movl   $0x21b,0x4(%esp)
c0104c43:	00 
c0104c44:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104c4b:	e8 c4 c0 ff ff       	call   c0100d14 <__panic>
    assert(boot_pgdir[0] & PTE_U);
c0104c50:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104c55:	8b 00                	mov    (%eax),%eax
c0104c57:	83 e0 04             	and    $0x4,%eax
c0104c5a:	85 c0                	test   %eax,%eax
c0104c5c:	75 24                	jne    c0104c82 <check_pgdir+0x395>
c0104c5e:	c7 44 24 0c a4 6e 10 	movl   $0xc0106ea4,0xc(%esp)
c0104c65:	c0 
c0104c66:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104c6d:	c0 
c0104c6e:	c7 44 24 04 1c 02 00 	movl   $0x21c,0x4(%esp)
c0104c75:	00 
c0104c76:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104c7d:	e8 92 c0 ff ff       	call   c0100d14 <__panic>
    assert(page_ref(p2) == 1);
c0104c82:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104c85:	89 04 24             	mov    %eax,(%esp)
c0104c88:	e8 a4 ef ff ff       	call   c0103c31 <page_ref>
c0104c8d:	83 f8 01             	cmp    $0x1,%eax
c0104c90:	74 24                	je     c0104cb6 <check_pgdir+0x3c9>
c0104c92:	c7 44 24 0c ba 6e 10 	movl   $0xc0106eba,0xc(%esp)
c0104c99:	c0 
c0104c9a:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104ca1:	c0 
c0104ca2:	c7 44 24 04 1d 02 00 	movl   $0x21d,0x4(%esp)
c0104ca9:	00 
c0104caa:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104cb1:	e8 5e c0 ff ff       	call   c0100d14 <__panic>

    assert(page_insert(boot_pgdir, p1, PGSIZE, 0) == 0);
c0104cb6:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104cbb:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
c0104cc2:	00 
c0104cc3:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
c0104cca:	00 
c0104ccb:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0104cce:	89 54 24 04          	mov    %edx,0x4(%esp)
c0104cd2:	89 04 24             	mov    %eax,(%esp)
c0104cd5:	e8 df fa ff ff       	call   c01047b9 <page_insert>
c0104cda:	85 c0                	test   %eax,%eax
c0104cdc:	74 24                	je     c0104d02 <check_pgdir+0x415>
c0104cde:	c7 44 24 0c cc 6e 10 	movl   $0xc0106ecc,0xc(%esp)
c0104ce5:	c0 
c0104ce6:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104ced:	c0 
c0104cee:	c7 44 24 04 1f 02 00 	movl   $0x21f,0x4(%esp)
c0104cf5:	00 
c0104cf6:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104cfd:	e8 12 c0 ff ff       	call   c0100d14 <__panic>
    assert(page_ref(p1) == 2);
c0104d02:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104d05:	89 04 24             	mov    %eax,(%esp)
c0104d08:	e8 24 ef ff ff       	call   c0103c31 <page_ref>
c0104d0d:	83 f8 02             	cmp    $0x2,%eax
c0104d10:	74 24                	je     c0104d36 <check_pgdir+0x449>
c0104d12:	c7 44 24 0c f8 6e 10 	movl   $0xc0106ef8,0xc(%esp)
c0104d19:	c0 
c0104d1a:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104d21:	c0 
c0104d22:	c7 44 24 04 20 02 00 	movl   $0x220,0x4(%esp)
c0104d29:	00 
c0104d2a:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104d31:	e8 de bf ff ff       	call   c0100d14 <__panic>
    assert(page_ref(p2) == 0);
c0104d36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104d39:	89 04 24             	mov    %eax,(%esp)
c0104d3c:	e8 f0 ee ff ff       	call   c0103c31 <page_ref>
c0104d41:	85 c0                	test   %eax,%eax
c0104d43:	74 24                	je     c0104d69 <check_pgdir+0x47c>
c0104d45:	c7 44 24 0c 0a 6f 10 	movl   $0xc0106f0a,0xc(%esp)
c0104d4c:	c0 
c0104d4d:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104d54:	c0 
c0104d55:	c7 44 24 04 21 02 00 	movl   $0x221,0x4(%esp)
c0104d5c:	00 
c0104d5d:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104d64:	e8 ab bf ff ff       	call   c0100d14 <__panic>
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
c0104d69:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104d6e:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c0104d75:	00 
c0104d76:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
c0104d7d:	00 
c0104d7e:	89 04 24             	mov    %eax,(%esp)
c0104d81:	e8 ef f7 ff ff       	call   c0104575 <get_pte>
c0104d86:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0104d89:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0104d8d:	75 24                	jne    c0104db3 <check_pgdir+0x4c6>
c0104d8f:	c7 44 24 0c 58 6e 10 	movl   $0xc0106e58,0xc(%esp)
c0104d96:	c0 
c0104d97:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104d9e:	c0 
c0104d9f:	c7 44 24 04 22 02 00 	movl   $0x222,0x4(%esp)
c0104da6:	00 
c0104da7:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104dae:	e8 61 bf ff ff       	call   c0100d14 <__panic>
    assert(pa2page(*ptep) == p1);
c0104db3:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104db6:	8b 00                	mov    (%eax),%eax
c0104db8:	89 04 24             	mov    %eax,(%esp)
c0104dbb:	e8 90 ed ff ff       	call   c0103b50 <pa2page>
c0104dc0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c0104dc3:	74 24                	je     c0104de9 <check_pgdir+0x4fc>
c0104dc5:	c7 44 24 0c d1 6d 10 	movl   $0xc0106dd1,0xc(%esp)
c0104dcc:	c0 
c0104dcd:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104dd4:	c0 
c0104dd5:	c7 44 24 04 23 02 00 	movl   $0x223,0x4(%esp)
c0104ddc:	00 
c0104ddd:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104de4:	e8 2b bf ff ff       	call   c0100d14 <__panic>
    assert((*ptep & PTE_U) == 0);
c0104de9:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104dec:	8b 00                	mov    (%eax),%eax
c0104dee:	83 e0 04             	and    $0x4,%eax
c0104df1:	85 c0                	test   %eax,%eax
c0104df3:	74 24                	je     c0104e19 <check_pgdir+0x52c>
c0104df5:	c7 44 24 0c 1c 6f 10 	movl   $0xc0106f1c,0xc(%esp)
c0104dfc:	c0 
c0104dfd:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104e04:	c0 
c0104e05:	c7 44 24 04 24 02 00 	movl   $0x224,0x4(%esp)
c0104e0c:	00 
c0104e0d:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104e14:	e8 fb be ff ff       	call   c0100d14 <__panic>

    page_remove(boot_pgdir, 0x0);
c0104e19:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104e1e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c0104e25:	00 
c0104e26:	89 04 24             	mov    %eax,(%esp)
c0104e29:	e8 47 f9 ff ff       	call   c0104775 <page_remove>
    assert(page_ref(p1) == 1);
c0104e2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104e31:	89 04 24             	mov    %eax,(%esp)
c0104e34:	e8 f8 ed ff ff       	call   c0103c31 <page_ref>
c0104e39:	83 f8 01             	cmp    $0x1,%eax
c0104e3c:	74 24                	je     c0104e62 <check_pgdir+0x575>
c0104e3e:	c7 44 24 0c e6 6d 10 	movl   $0xc0106de6,0xc(%esp)
c0104e45:	c0 
c0104e46:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104e4d:	c0 
c0104e4e:	c7 44 24 04 27 02 00 	movl   $0x227,0x4(%esp)
c0104e55:	00 
c0104e56:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104e5d:	e8 b2 be ff ff       	call   c0100d14 <__panic>
    assert(page_ref(p2) == 0);
c0104e62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104e65:	89 04 24             	mov    %eax,(%esp)
c0104e68:	e8 c4 ed ff ff       	call   c0103c31 <page_ref>
c0104e6d:	85 c0                	test   %eax,%eax
c0104e6f:	74 24                	je     c0104e95 <check_pgdir+0x5a8>
c0104e71:	c7 44 24 0c 0a 6f 10 	movl   $0xc0106f0a,0xc(%esp)
c0104e78:	c0 
c0104e79:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104e80:	c0 
c0104e81:	c7 44 24 04 28 02 00 	movl   $0x228,0x4(%esp)
c0104e88:	00 
c0104e89:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104e90:	e8 7f be ff ff       	call   c0100d14 <__panic>

    page_remove(boot_pgdir, PGSIZE);
c0104e95:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104e9a:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
c0104ea1:	00 
c0104ea2:	89 04 24             	mov    %eax,(%esp)
c0104ea5:	e8 cb f8 ff ff       	call   c0104775 <page_remove>
    assert(page_ref(p1) == 0);
c0104eaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104ead:	89 04 24             	mov    %eax,(%esp)
c0104eb0:	e8 7c ed ff ff       	call   c0103c31 <page_ref>
c0104eb5:	85 c0                	test   %eax,%eax
c0104eb7:	74 24                	je     c0104edd <check_pgdir+0x5f0>
c0104eb9:	c7 44 24 0c 31 6f 10 	movl   $0xc0106f31,0xc(%esp)
c0104ec0:	c0 
c0104ec1:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104ec8:	c0 
c0104ec9:	c7 44 24 04 2b 02 00 	movl   $0x22b,0x4(%esp)
c0104ed0:	00 
c0104ed1:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104ed8:	e8 37 be ff ff       	call   c0100d14 <__panic>
    assert(page_ref(p2) == 0);
c0104edd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104ee0:	89 04 24             	mov    %eax,(%esp)
c0104ee3:	e8 49 ed ff ff       	call   c0103c31 <page_ref>
c0104ee8:	85 c0                	test   %eax,%eax
c0104eea:	74 24                	je     c0104f10 <check_pgdir+0x623>
c0104eec:	c7 44 24 0c 0a 6f 10 	movl   $0xc0106f0a,0xc(%esp)
c0104ef3:	c0 
c0104ef4:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104efb:	c0 
c0104efc:	c7 44 24 04 2c 02 00 	movl   $0x22c,0x4(%esp)
c0104f03:	00 
c0104f04:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104f0b:	e8 04 be ff ff       	call   c0100d14 <__panic>

    assert(page_ref(pa2page(boot_pgdir[0])) == 1);
c0104f10:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104f15:	8b 00                	mov    (%eax),%eax
c0104f17:	89 04 24             	mov    %eax,(%esp)
c0104f1a:	e8 31 ec ff ff       	call   c0103b50 <pa2page>
c0104f1f:	89 04 24             	mov    %eax,(%esp)
c0104f22:	e8 0a ed ff ff       	call   c0103c31 <page_ref>
c0104f27:	83 f8 01             	cmp    $0x1,%eax
c0104f2a:	74 24                	je     c0104f50 <check_pgdir+0x663>
c0104f2c:	c7 44 24 0c 44 6f 10 	movl   $0xc0106f44,0xc(%esp)
c0104f33:	c0 
c0104f34:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0104f3b:	c0 
c0104f3c:	c7 44 24 04 2e 02 00 	movl   $0x22e,0x4(%esp)
c0104f43:	00 
c0104f44:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104f4b:	e8 c4 bd ff ff       	call   c0100d14 <__panic>
    free_page(pa2page(boot_pgdir[0]));
c0104f50:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104f55:	8b 00                	mov    (%eax),%eax
c0104f57:	89 04 24             	mov    %eax,(%esp)
c0104f5a:	e8 f1 eb ff ff       	call   c0103b50 <pa2page>
c0104f5f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c0104f66:	00 
c0104f67:	89 04 24             	mov    %eax,(%esp)
c0104f6a:	e8 ff ee ff ff       	call   c0103e6e <free_pages>
    boot_pgdir[0] = 0;
c0104f6f:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104f74:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("check_pgdir() succeeded!\n");
c0104f7a:	c7 04 24 6a 6f 10 c0 	movl   $0xc0106f6a,(%esp)
c0104f81:	e8 c6 b3 ff ff       	call   c010034c <cprintf>
}
c0104f86:	c9                   	leave  
c0104f87:	c3                   	ret    

c0104f88 <check_boot_pgdir>:

static void
check_boot_pgdir(void) {
c0104f88:	55                   	push   %ebp
c0104f89:	89 e5                	mov    %esp,%ebp
c0104f8b:	83 ec 38             	sub    $0x38,%esp
    pte_t *ptep;
    int i;
    for (i = 0; i < npage; i += PGSIZE) {
c0104f8e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0104f95:	e9 ca 00 00 00       	jmp    c0105064 <check_boot_pgdir+0xdc>
        assert((ptep = get_pte(boot_pgdir, (uintptr_t)KADDR(i), 0)) != NULL);
c0104f9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104f9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0104fa0:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104fa3:	c1 e8 0c             	shr    $0xc,%eax
c0104fa6:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0104fa9:	a1 c0 88 11 c0       	mov    0xc01188c0,%eax
c0104fae:	39 45 ec             	cmp    %eax,-0x14(%ebp)
c0104fb1:	72 23                	jb     c0104fd6 <check_boot_pgdir+0x4e>
c0104fb3:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104fb6:	89 44 24 0c          	mov    %eax,0xc(%esp)
c0104fba:	c7 44 24 08 b4 6b 10 	movl   $0xc0106bb4,0x8(%esp)
c0104fc1:	c0 
c0104fc2:	c7 44 24 04 3a 02 00 	movl   $0x23a,0x4(%esp)
c0104fc9:	00 
c0104fca:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0104fd1:	e8 3e bd ff ff       	call   c0100d14 <__panic>
c0104fd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104fd9:	2d 00 00 00 40       	sub    $0x40000000,%eax
c0104fde:	89 c2                	mov    %eax,%edx
c0104fe0:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0104fe5:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c0104fec:	00 
c0104fed:	89 54 24 04          	mov    %edx,0x4(%esp)
c0104ff1:	89 04 24             	mov    %eax,(%esp)
c0104ff4:	e8 7c f5 ff ff       	call   c0104575 <get_pte>
c0104ff9:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0104ffc:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105000:	75 24                	jne    c0105026 <check_boot_pgdir+0x9e>
c0105002:	c7 44 24 0c 84 6f 10 	movl   $0xc0106f84,0xc(%esp)
c0105009:	c0 
c010500a:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0105011:	c0 
c0105012:	c7 44 24 04 3a 02 00 	movl   $0x23a,0x4(%esp)
c0105019:	00 
c010501a:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0105021:	e8 ee bc ff ff       	call   c0100d14 <__panic>
        assert(PTE_ADDR(*ptep) == i);
c0105026:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105029:	8b 00                	mov    (%eax),%eax
c010502b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0105030:	89 c2                	mov    %eax,%edx
c0105032:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0105035:	39 c2                	cmp    %eax,%edx
c0105037:	74 24                	je     c010505d <check_boot_pgdir+0xd5>
c0105039:	c7 44 24 0c c1 6f 10 	movl   $0xc0106fc1,0xc(%esp)
c0105040:	c0 
c0105041:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0105048:	c0 
c0105049:	c7 44 24 04 3b 02 00 	movl   $0x23b,0x4(%esp)
c0105050:	00 
c0105051:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0105058:	e8 b7 bc ff ff       	call   c0100d14 <__panic>

static void
check_boot_pgdir(void) {
    pte_t *ptep;
    int i;
    for (i = 0; i < npage; i += PGSIZE) {
c010505d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
c0105064:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0105067:	a1 c0 88 11 c0       	mov    0xc01188c0,%eax
c010506c:	39 c2                	cmp    %eax,%edx
c010506e:	0f 82 26 ff ff ff    	jb     c0104f9a <check_boot_pgdir+0x12>
        assert((ptep = get_pte(boot_pgdir, (uintptr_t)KADDR(i), 0)) != NULL);
        assert(PTE_ADDR(*ptep) == i);
    }

    assert(PDE_ADDR(boot_pgdir[PDX(VPT)]) == PADDR(boot_pgdir));
c0105074:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0105079:	05 ac 0f 00 00       	add    $0xfac,%eax
c010507e:	8b 00                	mov    (%eax),%eax
c0105080:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0105085:	89 c2                	mov    %eax,%edx
c0105087:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c010508c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c010508f:	81 7d e4 ff ff ff bf 	cmpl   $0xbfffffff,-0x1c(%ebp)
c0105096:	77 23                	ja     c01050bb <check_boot_pgdir+0x133>
c0105098:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010509b:	89 44 24 0c          	mov    %eax,0xc(%esp)
c010509f:	c7 44 24 08 58 6c 10 	movl   $0xc0106c58,0x8(%esp)
c01050a6:	c0 
c01050a7:	c7 44 24 04 3e 02 00 	movl   $0x23e,0x4(%esp)
c01050ae:	00 
c01050af:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c01050b6:	e8 59 bc ff ff       	call   c0100d14 <__panic>
c01050bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01050be:	05 00 00 00 40       	add    $0x40000000,%eax
c01050c3:	39 c2                	cmp    %eax,%edx
c01050c5:	74 24                	je     c01050eb <check_boot_pgdir+0x163>
c01050c7:	c7 44 24 0c d8 6f 10 	movl   $0xc0106fd8,0xc(%esp)
c01050ce:	c0 
c01050cf:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c01050d6:	c0 
c01050d7:	c7 44 24 04 3e 02 00 	movl   $0x23e,0x4(%esp)
c01050de:	00 
c01050df:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c01050e6:	e8 29 bc ff ff       	call   c0100d14 <__panic>

    assert(boot_pgdir[0] == 0);
c01050eb:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c01050f0:	8b 00                	mov    (%eax),%eax
c01050f2:	85 c0                	test   %eax,%eax
c01050f4:	74 24                	je     c010511a <check_boot_pgdir+0x192>
c01050f6:	c7 44 24 0c 0c 70 10 	movl   $0xc010700c,0xc(%esp)
c01050fd:	c0 
c01050fe:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0105105:	c0 
c0105106:	c7 44 24 04 40 02 00 	movl   $0x240,0x4(%esp)
c010510d:	00 
c010510e:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0105115:	e8 fa bb ff ff       	call   c0100d14 <__panic>

    struct Page *p;
    p = alloc_page();
c010511a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0105121:	e8 10 ed ff ff       	call   c0103e36 <alloc_pages>
c0105126:	89 45 e0             	mov    %eax,-0x20(%ebp)
    assert(page_insert(boot_pgdir, p, 0x100, PTE_W) == 0);
c0105129:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c010512e:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
c0105135:	00 
c0105136:	c7 44 24 08 00 01 00 	movl   $0x100,0x8(%esp)
c010513d:	00 
c010513e:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0105141:	89 54 24 04          	mov    %edx,0x4(%esp)
c0105145:	89 04 24             	mov    %eax,(%esp)
c0105148:	e8 6c f6 ff ff       	call   c01047b9 <page_insert>
c010514d:	85 c0                	test   %eax,%eax
c010514f:	74 24                	je     c0105175 <check_boot_pgdir+0x1ed>
c0105151:	c7 44 24 0c 20 70 10 	movl   $0xc0107020,0xc(%esp)
c0105158:	c0 
c0105159:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0105160:	c0 
c0105161:	c7 44 24 04 44 02 00 	movl   $0x244,0x4(%esp)
c0105168:	00 
c0105169:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0105170:	e8 9f bb ff ff       	call   c0100d14 <__panic>
    assert(page_ref(p) == 1);
c0105175:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105178:	89 04 24             	mov    %eax,(%esp)
c010517b:	e8 b1 ea ff ff       	call   c0103c31 <page_ref>
c0105180:	83 f8 01             	cmp    $0x1,%eax
c0105183:	74 24                	je     c01051a9 <check_boot_pgdir+0x221>
c0105185:	c7 44 24 0c 4e 70 10 	movl   $0xc010704e,0xc(%esp)
c010518c:	c0 
c010518d:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0105194:	c0 
c0105195:	c7 44 24 04 45 02 00 	movl   $0x245,0x4(%esp)
c010519c:	00 
c010519d:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c01051a4:	e8 6b bb ff ff       	call   c0100d14 <__panic>
    assert(page_insert(boot_pgdir, p, 0x100 + PGSIZE, PTE_W) == 0);
c01051a9:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c01051ae:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
c01051b5:	00 
c01051b6:	c7 44 24 08 00 11 00 	movl   $0x1100,0x8(%esp)
c01051bd:	00 
c01051be:	8b 55 e0             	mov    -0x20(%ebp),%edx
c01051c1:	89 54 24 04          	mov    %edx,0x4(%esp)
c01051c5:	89 04 24             	mov    %eax,(%esp)
c01051c8:	e8 ec f5 ff ff       	call   c01047b9 <page_insert>
c01051cd:	85 c0                	test   %eax,%eax
c01051cf:	74 24                	je     c01051f5 <check_boot_pgdir+0x26d>
c01051d1:	c7 44 24 0c 60 70 10 	movl   $0xc0107060,0xc(%esp)
c01051d8:	c0 
c01051d9:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c01051e0:	c0 
c01051e1:	c7 44 24 04 46 02 00 	movl   $0x246,0x4(%esp)
c01051e8:	00 
c01051e9:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c01051f0:	e8 1f bb ff ff       	call   c0100d14 <__panic>
    assert(page_ref(p) == 2);
c01051f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01051f8:	89 04 24             	mov    %eax,(%esp)
c01051fb:	e8 31 ea ff ff       	call   c0103c31 <page_ref>
c0105200:	83 f8 02             	cmp    $0x2,%eax
c0105203:	74 24                	je     c0105229 <check_boot_pgdir+0x2a1>
c0105205:	c7 44 24 0c 97 70 10 	movl   $0xc0107097,0xc(%esp)
c010520c:	c0 
c010520d:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c0105214:	c0 
c0105215:	c7 44 24 04 47 02 00 	movl   $0x247,0x4(%esp)
c010521c:	00 
c010521d:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c0105224:	e8 eb ba ff ff       	call   c0100d14 <__panic>

    const char *str = "ucore: Hello world!!";
c0105229:	c7 45 dc a8 70 10 c0 	movl   $0xc01070a8,-0x24(%ebp)
    strcpy((void *)0x100, str);
c0105230:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0105233:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105237:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
c010523e:	e8 1e 0a 00 00       	call   c0105c61 <strcpy>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
c0105243:	c7 44 24 04 00 11 00 	movl   $0x1100,0x4(%esp)
c010524a:	00 
c010524b:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
c0105252:	e8 83 0a 00 00       	call   c0105cda <strcmp>
c0105257:	85 c0                	test   %eax,%eax
c0105259:	74 24                	je     c010527f <check_boot_pgdir+0x2f7>
c010525b:	c7 44 24 0c c0 70 10 	movl   $0xc01070c0,0xc(%esp)
c0105262:	c0 
c0105263:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c010526a:	c0 
c010526b:	c7 44 24 04 4b 02 00 	movl   $0x24b,0x4(%esp)
c0105272:	00 
c0105273:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c010527a:	e8 95 ba ff ff       	call   c0100d14 <__panic>

    *(char *)(page2kva(p) + 0x100) = '\0';
c010527f:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105282:	89 04 24             	mov    %eax,(%esp)
c0105285:	e8 15 e9 ff ff       	call   c0103b9f <page2kva>
c010528a:	05 00 01 00 00       	add    $0x100,%eax
c010528f:	c6 00 00             	movb   $0x0,(%eax)
    assert(strlen((const char *)0x100) == 0);
c0105292:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
c0105299:	e8 6b 09 00 00       	call   c0105c09 <strlen>
c010529e:	85 c0                	test   %eax,%eax
c01052a0:	74 24                	je     c01052c6 <check_boot_pgdir+0x33e>
c01052a2:	c7 44 24 0c f8 70 10 	movl   $0xc01070f8,0xc(%esp)
c01052a9:	c0 
c01052aa:	c7 44 24 08 a1 6c 10 	movl   $0xc0106ca1,0x8(%esp)
c01052b1:	c0 
c01052b2:	c7 44 24 04 4e 02 00 	movl   $0x24e,0x4(%esp)
c01052b9:	00 
c01052ba:	c7 04 24 7c 6c 10 c0 	movl   $0xc0106c7c,(%esp)
c01052c1:	e8 4e ba ff ff       	call   c0100d14 <__panic>

    free_page(p);
c01052c6:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c01052cd:	00 
c01052ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01052d1:	89 04 24             	mov    %eax,(%esp)
c01052d4:	e8 95 eb ff ff       	call   c0103e6e <free_pages>
    free_page(pa2page(PDE_ADDR(boot_pgdir[0])));
c01052d9:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c01052de:	8b 00                	mov    (%eax),%eax
c01052e0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c01052e5:	89 04 24             	mov    %eax,(%esp)
c01052e8:	e8 63 e8 ff ff       	call   c0103b50 <pa2page>
c01052ed:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c01052f4:	00 
c01052f5:	89 04 24             	mov    %eax,(%esp)
c01052f8:	e8 71 eb ff ff       	call   c0103e6e <free_pages>
    boot_pgdir[0] = 0;
c01052fd:	a1 c4 88 11 c0       	mov    0xc01188c4,%eax
c0105302:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("check_boot_pgdir() succeeded!\n");
c0105308:	c7 04 24 1c 71 10 c0 	movl   $0xc010711c,(%esp)
c010530f:	e8 38 b0 ff ff       	call   c010034c <cprintf>
}
c0105314:	c9                   	leave  
c0105315:	c3                   	ret    

c0105316 <perm2str>:

//perm2str - use string 'u,r,w,-' to present the permission
static const char *
perm2str(int perm) {
c0105316:	55                   	push   %ebp
c0105317:	89 e5                	mov    %esp,%ebp
    static char str[4];
    str[0] = (perm & PTE_U) ? 'u' : '-';
c0105319:	8b 45 08             	mov    0x8(%ebp),%eax
c010531c:	83 e0 04             	and    $0x4,%eax
c010531f:	85 c0                	test   %eax,%eax
c0105321:	74 07                	je     c010532a <perm2str+0x14>
c0105323:	b8 75 00 00 00       	mov    $0x75,%eax
c0105328:	eb 05                	jmp    c010532f <perm2str+0x19>
c010532a:	b8 2d 00 00 00       	mov    $0x2d,%eax
c010532f:	a2 48 89 11 c0       	mov    %al,0xc0118948
    str[1] = 'r';
c0105334:	c6 05 49 89 11 c0 72 	movb   $0x72,0xc0118949
    str[2] = (perm & PTE_W) ? 'w' : '-';
c010533b:	8b 45 08             	mov    0x8(%ebp),%eax
c010533e:	83 e0 02             	and    $0x2,%eax
c0105341:	85 c0                	test   %eax,%eax
c0105343:	74 07                	je     c010534c <perm2str+0x36>
c0105345:	b8 77 00 00 00       	mov    $0x77,%eax
c010534a:	eb 05                	jmp    c0105351 <perm2str+0x3b>
c010534c:	b8 2d 00 00 00       	mov    $0x2d,%eax
c0105351:	a2 4a 89 11 c0       	mov    %al,0xc011894a
    str[3] = '\0';
c0105356:	c6 05 4b 89 11 c0 00 	movb   $0x0,0xc011894b
    return str;
c010535d:	b8 48 89 11 c0       	mov    $0xc0118948,%eax
}
c0105362:	5d                   	pop    %ebp
c0105363:	c3                   	ret    

c0105364 <get_pgtable_items>:
//  table:       the beginning addr of table
//  left_store:  the pointer of the high side of table's next range
//  right_store: the pointer of the low side of table's next range
// return value: 0 - not a invalid item range, perm - a valid item range with perm permission 
static int
get_pgtable_items(size_t left, size_t right, size_t start, uintptr_t *table, size_t *left_store, size_t *right_store) {
c0105364:	55                   	push   %ebp
c0105365:	89 e5                	mov    %esp,%ebp
c0105367:	83 ec 10             	sub    $0x10,%esp
    if (start >= right) {
c010536a:	8b 45 10             	mov    0x10(%ebp),%eax
c010536d:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0105370:	72 0a                	jb     c010537c <get_pgtable_items+0x18>
        return 0;
c0105372:	b8 00 00 00 00       	mov    $0x0,%eax
c0105377:	e9 9c 00 00 00       	jmp    c0105418 <get_pgtable_items+0xb4>
    }
    while (start < right && !(table[start] & PTE_P)) {
c010537c:	eb 04                	jmp    c0105382 <get_pgtable_items+0x1e>
        start ++;
c010537e:	83 45 10 01          	addl   $0x1,0x10(%ebp)
static int
get_pgtable_items(size_t left, size_t right, size_t start, uintptr_t *table, size_t *left_store, size_t *right_store) {
    if (start >= right) {
        return 0;
    }
    while (start < right && !(table[start] & PTE_P)) {
c0105382:	8b 45 10             	mov    0x10(%ebp),%eax
c0105385:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0105388:	73 18                	jae    c01053a2 <get_pgtable_items+0x3e>
c010538a:	8b 45 10             	mov    0x10(%ebp),%eax
c010538d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0105394:	8b 45 14             	mov    0x14(%ebp),%eax
c0105397:	01 d0                	add    %edx,%eax
c0105399:	8b 00                	mov    (%eax),%eax
c010539b:	83 e0 01             	and    $0x1,%eax
c010539e:	85 c0                	test   %eax,%eax
c01053a0:	74 dc                	je     c010537e <get_pgtable_items+0x1a>
        start ++;
    }
    if (start < right) {
c01053a2:	8b 45 10             	mov    0x10(%ebp),%eax
c01053a5:	3b 45 0c             	cmp    0xc(%ebp),%eax
c01053a8:	73 69                	jae    c0105413 <get_pgtable_items+0xaf>
        if (left_store != NULL) {
c01053aa:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
c01053ae:	74 08                	je     c01053b8 <get_pgtable_items+0x54>
            *left_store = start;
c01053b0:	8b 45 18             	mov    0x18(%ebp),%eax
c01053b3:	8b 55 10             	mov    0x10(%ebp),%edx
c01053b6:	89 10                	mov    %edx,(%eax)
        }
        int perm = (table[start ++] & PTE_USER);
c01053b8:	8b 45 10             	mov    0x10(%ebp),%eax
c01053bb:	8d 50 01             	lea    0x1(%eax),%edx
c01053be:	89 55 10             	mov    %edx,0x10(%ebp)
c01053c1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c01053c8:	8b 45 14             	mov    0x14(%ebp),%eax
c01053cb:	01 d0                	add    %edx,%eax
c01053cd:	8b 00                	mov    (%eax),%eax
c01053cf:	83 e0 07             	and    $0x7,%eax
c01053d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
        while (start < right && (table[start] & PTE_USER) == perm) {
c01053d5:	eb 04                	jmp    c01053db <get_pgtable_items+0x77>
            start ++;
c01053d7:	83 45 10 01          	addl   $0x1,0x10(%ebp)
    if (start < right) {
        if (left_store != NULL) {
            *left_store = start;
        }
        int perm = (table[start ++] & PTE_USER);
        while (start < right && (table[start] & PTE_USER) == perm) {
c01053db:	8b 45 10             	mov    0x10(%ebp),%eax
c01053de:	3b 45 0c             	cmp    0xc(%ebp),%eax
c01053e1:	73 1d                	jae    c0105400 <get_pgtable_items+0x9c>
c01053e3:	8b 45 10             	mov    0x10(%ebp),%eax
c01053e6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c01053ed:	8b 45 14             	mov    0x14(%ebp),%eax
c01053f0:	01 d0                	add    %edx,%eax
c01053f2:	8b 00                	mov    (%eax),%eax
c01053f4:	83 e0 07             	and    $0x7,%eax
c01053f7:	89 c2                	mov    %eax,%edx
c01053f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01053fc:	39 c2                	cmp    %eax,%edx
c01053fe:	74 d7                	je     c01053d7 <get_pgtable_items+0x73>
            start ++;
        }
        if (right_store != NULL) {
c0105400:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
c0105404:	74 08                	je     c010540e <get_pgtable_items+0xaa>
            *right_store = start;
c0105406:	8b 45 1c             	mov    0x1c(%ebp),%eax
c0105409:	8b 55 10             	mov    0x10(%ebp),%edx
c010540c:	89 10                	mov    %edx,(%eax)
        }
        return perm;
c010540e:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0105411:	eb 05                	jmp    c0105418 <get_pgtable_items+0xb4>
    }
    return 0;
c0105413:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0105418:	c9                   	leave  
c0105419:	c3                   	ret    

c010541a <print_pgdir>:

//print_pgdir - print the PDT&PT
void
print_pgdir(void) {
c010541a:	55                   	push   %ebp
c010541b:	89 e5                	mov    %esp,%ebp
c010541d:	57                   	push   %edi
c010541e:	56                   	push   %esi
c010541f:	53                   	push   %ebx
c0105420:	83 ec 4c             	sub    $0x4c,%esp
    cprintf("-------------------- BEGIN --------------------\n");
c0105423:	c7 04 24 3c 71 10 c0 	movl   $0xc010713c,(%esp)
c010542a:	e8 1d af ff ff       	call   c010034c <cprintf>
    size_t left, right = 0, perm;
c010542f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
c0105436:	e9 fa 00 00 00       	jmp    c0105535 <print_pgdir+0x11b>
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
c010543b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010543e:	89 04 24             	mov    %eax,(%esp)
c0105441:	e8 d0 fe ff ff       	call   c0105316 <perm2str>
                left * PTSIZE, right * PTSIZE, (right - left) * PTSIZE, perm2str(perm));
c0105446:	8b 4d dc             	mov    -0x24(%ebp),%ecx
c0105449:	8b 55 e0             	mov    -0x20(%ebp),%edx
c010544c:	29 d1                	sub    %edx,%ecx
c010544e:	89 ca                	mov    %ecx,%edx
void
print_pgdir(void) {
    cprintf("-------------------- BEGIN --------------------\n");
    size_t left, right = 0, perm;
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
c0105450:	89 d6                	mov    %edx,%esi
c0105452:	c1 e6 16             	shl    $0x16,%esi
c0105455:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0105458:	89 d3                	mov    %edx,%ebx
c010545a:	c1 e3 16             	shl    $0x16,%ebx
c010545d:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0105460:	89 d1                	mov    %edx,%ecx
c0105462:	c1 e1 16             	shl    $0x16,%ecx
c0105465:	8b 7d dc             	mov    -0x24(%ebp),%edi
c0105468:	8b 55 e0             	mov    -0x20(%ebp),%edx
c010546b:	29 d7                	sub    %edx,%edi
c010546d:	89 fa                	mov    %edi,%edx
c010546f:	89 44 24 14          	mov    %eax,0x14(%esp)
c0105473:	89 74 24 10          	mov    %esi,0x10(%esp)
c0105477:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
c010547b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
c010547f:	89 54 24 04          	mov    %edx,0x4(%esp)
c0105483:	c7 04 24 6d 71 10 c0 	movl   $0xc010716d,(%esp)
c010548a:	e8 bd ae ff ff       	call   c010034c <cprintf>
                left * PTSIZE, right * PTSIZE, (right - left) * PTSIZE, perm2str(perm));
        size_t l, r = left * NPTEENTRY;
c010548f:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105492:	c1 e0 0a             	shl    $0xa,%eax
c0105495:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
c0105498:	eb 54                	jmp    c01054ee <print_pgdir+0xd4>
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
c010549a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010549d:	89 04 24             	mov    %eax,(%esp)
c01054a0:	e8 71 fe ff ff       	call   c0105316 <perm2str>
                    l * PGSIZE, r * PGSIZE, (r - l) * PGSIZE, perm2str(perm));
c01054a5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
c01054a8:	8b 55 d8             	mov    -0x28(%ebp),%edx
c01054ab:	29 d1                	sub    %edx,%ecx
c01054ad:	89 ca                	mov    %ecx,%edx
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
                left * PTSIZE, right * PTSIZE, (right - left) * PTSIZE, perm2str(perm));
        size_t l, r = left * NPTEENTRY;
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
c01054af:	89 d6                	mov    %edx,%esi
c01054b1:	c1 e6 0c             	shl    $0xc,%esi
c01054b4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c01054b7:	89 d3                	mov    %edx,%ebx
c01054b9:	c1 e3 0c             	shl    $0xc,%ebx
c01054bc:	8b 55 d8             	mov    -0x28(%ebp),%edx
c01054bf:	c1 e2 0c             	shl    $0xc,%edx
c01054c2:	89 d1                	mov    %edx,%ecx
c01054c4:	8b 7d d4             	mov    -0x2c(%ebp),%edi
c01054c7:	8b 55 d8             	mov    -0x28(%ebp),%edx
c01054ca:	29 d7                	sub    %edx,%edi
c01054cc:	89 fa                	mov    %edi,%edx
c01054ce:	89 44 24 14          	mov    %eax,0x14(%esp)
c01054d2:	89 74 24 10          	mov    %esi,0x10(%esp)
c01054d6:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
c01054da:	89 4c 24 08          	mov    %ecx,0x8(%esp)
c01054de:	89 54 24 04          	mov    %edx,0x4(%esp)
c01054e2:	c7 04 24 8c 71 10 c0 	movl   $0xc010718c,(%esp)
c01054e9:	e8 5e ae ff ff       	call   c010034c <cprintf>
    size_t left, right = 0, perm;
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
                left * PTSIZE, right * PTSIZE, (right - left) * PTSIZE, perm2str(perm));
        size_t l, r = left * NPTEENTRY;
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
c01054ee:	ba 00 00 c0 fa       	mov    $0xfac00000,%edx
c01054f3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c01054f6:	8b 4d dc             	mov    -0x24(%ebp),%ecx
c01054f9:	89 ce                	mov    %ecx,%esi
c01054fb:	c1 e6 0a             	shl    $0xa,%esi
c01054fe:	8b 4d e0             	mov    -0x20(%ebp),%ecx
c0105501:	89 cb                	mov    %ecx,%ebx
c0105503:	c1 e3 0a             	shl    $0xa,%ebx
c0105506:	8d 4d d4             	lea    -0x2c(%ebp),%ecx
c0105509:	89 4c 24 14          	mov    %ecx,0x14(%esp)
c010550d:	8d 4d d8             	lea    -0x28(%ebp),%ecx
c0105510:	89 4c 24 10          	mov    %ecx,0x10(%esp)
c0105514:	89 54 24 0c          	mov    %edx,0xc(%esp)
c0105518:	89 44 24 08          	mov    %eax,0x8(%esp)
c010551c:	89 74 24 04          	mov    %esi,0x4(%esp)
c0105520:	89 1c 24             	mov    %ebx,(%esp)
c0105523:	e8 3c fe ff ff       	call   c0105364 <get_pgtable_items>
c0105528:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c010552b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c010552f:	0f 85 65 ff ff ff    	jne    c010549a <print_pgdir+0x80>
//print_pgdir - print the PDT&PT
void
print_pgdir(void) {
    cprintf("-------------------- BEGIN --------------------\n");
    size_t left, right = 0, perm;
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
c0105535:	ba 00 b0 fe fa       	mov    $0xfafeb000,%edx
c010553a:	8b 45 dc             	mov    -0x24(%ebp),%eax
c010553d:	8d 4d dc             	lea    -0x24(%ebp),%ecx
c0105540:	89 4c 24 14          	mov    %ecx,0x14(%esp)
c0105544:	8d 4d e0             	lea    -0x20(%ebp),%ecx
c0105547:	89 4c 24 10          	mov    %ecx,0x10(%esp)
c010554b:	89 54 24 0c          	mov    %edx,0xc(%esp)
c010554f:	89 44 24 08          	mov    %eax,0x8(%esp)
c0105553:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
c010555a:	00 
c010555b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
c0105562:	e8 fd fd ff ff       	call   c0105364 <get_pgtable_items>
c0105567:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c010556a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c010556e:	0f 85 c7 fe ff ff    	jne    c010543b <print_pgdir+0x21>
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
                    l * PGSIZE, r * PGSIZE, (r - l) * PGSIZE, perm2str(perm));
        }
    }
    cprintf("--------------------- END ---------------------\n");
c0105574:	c7 04 24 b0 71 10 c0 	movl   $0xc01071b0,(%esp)
c010557b:	e8 cc ad ff ff       	call   c010034c <cprintf>
}
c0105580:	83 c4 4c             	add    $0x4c,%esp
c0105583:	5b                   	pop    %ebx
c0105584:	5e                   	pop    %esi
c0105585:	5f                   	pop    %edi
c0105586:	5d                   	pop    %ebp
c0105587:	c3                   	ret    

c0105588 <printnum>:
 * @width:      maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:       character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
c0105588:	55                   	push   %ebp
c0105589:	89 e5                	mov    %esp,%ebp
c010558b:	83 ec 58             	sub    $0x58,%esp
c010558e:	8b 45 10             	mov    0x10(%ebp),%eax
c0105591:	89 45 d0             	mov    %eax,-0x30(%ebp)
c0105594:	8b 45 14             	mov    0x14(%ebp),%eax
c0105597:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
c010559a:	8b 45 d0             	mov    -0x30(%ebp),%eax
c010559d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c01055a0:	89 45 e8             	mov    %eax,-0x18(%ebp)
c01055a3:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
c01055a6:	8b 45 18             	mov    0x18(%ebp),%eax
c01055a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c01055ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01055af:	8b 55 ec             	mov    -0x14(%ebp),%edx
c01055b2:	89 45 e0             	mov    %eax,-0x20(%ebp)
c01055b5:	89 55 f0             	mov    %edx,-0x10(%ebp)
c01055b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01055bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01055be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c01055c2:	74 1c                	je     c01055e0 <printnum+0x58>
c01055c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01055c7:	ba 00 00 00 00       	mov    $0x0,%edx
c01055cc:	f7 75 e4             	divl   -0x1c(%ebp)
c01055cf:	89 55 f4             	mov    %edx,-0xc(%ebp)
c01055d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01055d5:	ba 00 00 00 00       	mov    $0x0,%edx
c01055da:	f7 75 e4             	divl   -0x1c(%ebp)
c01055dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01055e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01055e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
c01055e6:	f7 75 e4             	divl   -0x1c(%ebp)
c01055e9:	89 45 e0             	mov    %eax,-0x20(%ebp)
c01055ec:	89 55 dc             	mov    %edx,-0x24(%ebp)
c01055ef:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01055f2:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01055f5:	89 45 e8             	mov    %eax,-0x18(%ebp)
c01055f8:	89 55 ec             	mov    %edx,-0x14(%ebp)
c01055fb:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01055fe:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
c0105601:	8b 45 18             	mov    0x18(%ebp),%eax
c0105604:	ba 00 00 00 00       	mov    $0x0,%edx
c0105609:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
c010560c:	77 56                	ja     c0105664 <printnum+0xdc>
c010560e:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
c0105611:	72 05                	jb     c0105618 <printnum+0x90>
c0105613:	3b 45 d0             	cmp    -0x30(%ebp),%eax
c0105616:	77 4c                	ja     c0105664 <printnum+0xdc>
        printnum(putch, putdat, result, base, width - 1, padc);
c0105618:	8b 45 1c             	mov    0x1c(%ebp),%eax
c010561b:	8d 50 ff             	lea    -0x1(%eax),%edx
c010561e:	8b 45 20             	mov    0x20(%ebp),%eax
c0105621:	89 44 24 18          	mov    %eax,0x18(%esp)
c0105625:	89 54 24 14          	mov    %edx,0x14(%esp)
c0105629:	8b 45 18             	mov    0x18(%ebp),%eax
c010562c:	89 44 24 10          	mov    %eax,0x10(%esp)
c0105630:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105633:	8b 55 ec             	mov    -0x14(%ebp),%edx
c0105636:	89 44 24 08          	mov    %eax,0x8(%esp)
c010563a:	89 54 24 0c          	mov    %edx,0xc(%esp)
c010563e:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105641:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105645:	8b 45 08             	mov    0x8(%ebp),%eax
c0105648:	89 04 24             	mov    %eax,(%esp)
c010564b:	e8 38 ff ff ff       	call   c0105588 <printnum>
c0105650:	eb 1c                	jmp    c010566e <printnum+0xe6>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
c0105652:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105655:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105659:	8b 45 20             	mov    0x20(%ebp),%eax
c010565c:	89 04 24             	mov    %eax,(%esp)
c010565f:	8b 45 08             	mov    0x8(%ebp),%eax
c0105662:	ff d0                	call   *%eax
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
c0105664:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
c0105668:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
c010566c:	7f e4                	jg     c0105652 <printnum+0xca>
            putch(padc, putdat);
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
c010566e:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0105671:	05 64 72 10 c0       	add    $0xc0107264,%eax
c0105676:	0f b6 00             	movzbl (%eax),%eax
c0105679:	0f be c0             	movsbl %al,%eax
c010567c:	8b 55 0c             	mov    0xc(%ebp),%edx
c010567f:	89 54 24 04          	mov    %edx,0x4(%esp)
c0105683:	89 04 24             	mov    %eax,(%esp)
c0105686:	8b 45 08             	mov    0x8(%ebp),%eax
c0105689:	ff d0                	call   *%eax
}
c010568b:	c9                   	leave  
c010568c:	c3                   	ret    

c010568d <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
c010568d:	55                   	push   %ebp
c010568e:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
c0105690:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
c0105694:	7e 14                	jle    c01056aa <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
c0105696:	8b 45 08             	mov    0x8(%ebp),%eax
c0105699:	8b 00                	mov    (%eax),%eax
c010569b:	8d 48 08             	lea    0x8(%eax),%ecx
c010569e:	8b 55 08             	mov    0x8(%ebp),%edx
c01056a1:	89 0a                	mov    %ecx,(%edx)
c01056a3:	8b 50 04             	mov    0x4(%eax),%edx
c01056a6:	8b 00                	mov    (%eax),%eax
c01056a8:	eb 30                	jmp    c01056da <getuint+0x4d>
    }
    else if (lflag) {
c01056aa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c01056ae:	74 16                	je     c01056c6 <getuint+0x39>
        return va_arg(*ap, unsigned long);
c01056b0:	8b 45 08             	mov    0x8(%ebp),%eax
c01056b3:	8b 00                	mov    (%eax),%eax
c01056b5:	8d 48 04             	lea    0x4(%eax),%ecx
c01056b8:	8b 55 08             	mov    0x8(%ebp),%edx
c01056bb:	89 0a                	mov    %ecx,(%edx)
c01056bd:	8b 00                	mov    (%eax),%eax
c01056bf:	ba 00 00 00 00       	mov    $0x0,%edx
c01056c4:	eb 14                	jmp    c01056da <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
c01056c6:	8b 45 08             	mov    0x8(%ebp),%eax
c01056c9:	8b 00                	mov    (%eax),%eax
c01056cb:	8d 48 04             	lea    0x4(%eax),%ecx
c01056ce:	8b 55 08             	mov    0x8(%ebp),%edx
c01056d1:	89 0a                	mov    %ecx,(%edx)
c01056d3:	8b 00                	mov    (%eax),%eax
c01056d5:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
c01056da:	5d                   	pop    %ebp
c01056db:	c3                   	ret    

c01056dc <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
c01056dc:	55                   	push   %ebp
c01056dd:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
c01056df:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
c01056e3:	7e 14                	jle    c01056f9 <getint+0x1d>
        return va_arg(*ap, long long);
c01056e5:	8b 45 08             	mov    0x8(%ebp),%eax
c01056e8:	8b 00                	mov    (%eax),%eax
c01056ea:	8d 48 08             	lea    0x8(%eax),%ecx
c01056ed:	8b 55 08             	mov    0x8(%ebp),%edx
c01056f0:	89 0a                	mov    %ecx,(%edx)
c01056f2:	8b 50 04             	mov    0x4(%eax),%edx
c01056f5:	8b 00                	mov    (%eax),%eax
c01056f7:	eb 28                	jmp    c0105721 <getint+0x45>
    }
    else if (lflag) {
c01056f9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c01056fd:	74 12                	je     c0105711 <getint+0x35>
        return va_arg(*ap, long);
c01056ff:	8b 45 08             	mov    0x8(%ebp),%eax
c0105702:	8b 00                	mov    (%eax),%eax
c0105704:	8d 48 04             	lea    0x4(%eax),%ecx
c0105707:	8b 55 08             	mov    0x8(%ebp),%edx
c010570a:	89 0a                	mov    %ecx,(%edx)
c010570c:	8b 00                	mov    (%eax),%eax
c010570e:	99                   	cltd   
c010570f:	eb 10                	jmp    c0105721 <getint+0x45>
    }
    else {
        return va_arg(*ap, int);
c0105711:	8b 45 08             	mov    0x8(%ebp),%eax
c0105714:	8b 00                	mov    (%eax),%eax
c0105716:	8d 48 04             	lea    0x4(%eax),%ecx
c0105719:	8b 55 08             	mov    0x8(%ebp),%edx
c010571c:	89 0a                	mov    %ecx,(%edx)
c010571e:	8b 00                	mov    (%eax),%eax
c0105720:	99                   	cltd   
    }
}
c0105721:	5d                   	pop    %ebp
c0105722:	c3                   	ret    

c0105723 <printfmt>:
 * @putch:      specified putch function, print a single character
 * @putdat:     used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
c0105723:	55                   	push   %ebp
c0105724:	89 e5                	mov    %esp,%ebp
c0105726:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
c0105729:	8d 45 14             	lea    0x14(%ebp),%eax
c010572c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
c010572f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0105732:	89 44 24 0c          	mov    %eax,0xc(%esp)
c0105736:	8b 45 10             	mov    0x10(%ebp),%eax
c0105739:	89 44 24 08          	mov    %eax,0x8(%esp)
c010573d:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105740:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105744:	8b 45 08             	mov    0x8(%ebp),%eax
c0105747:	89 04 24             	mov    %eax,(%esp)
c010574a:	e8 02 00 00 00       	call   c0105751 <vprintfmt>
    va_end(ap);
}
c010574f:	c9                   	leave  
c0105750:	c3                   	ret    

c0105751 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
c0105751:	55                   	push   %ebp
c0105752:	89 e5                	mov    %esp,%ebp
c0105754:	56                   	push   %esi
c0105755:	53                   	push   %ebx
c0105756:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
c0105759:	eb 18                	jmp    c0105773 <vprintfmt+0x22>
            if (ch == '\0') {
c010575b:	85 db                	test   %ebx,%ebx
c010575d:	75 05                	jne    c0105764 <vprintfmt+0x13>
                return;
c010575f:	e9 d1 03 00 00       	jmp    c0105b35 <vprintfmt+0x3e4>
            }
            putch(ch, putdat);
c0105764:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105767:	89 44 24 04          	mov    %eax,0x4(%esp)
c010576b:	89 1c 24             	mov    %ebx,(%esp)
c010576e:	8b 45 08             	mov    0x8(%ebp),%eax
c0105771:	ff d0                	call   *%eax
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
c0105773:	8b 45 10             	mov    0x10(%ebp),%eax
c0105776:	8d 50 01             	lea    0x1(%eax),%edx
c0105779:	89 55 10             	mov    %edx,0x10(%ebp)
c010577c:	0f b6 00             	movzbl (%eax),%eax
c010577f:	0f b6 d8             	movzbl %al,%ebx
c0105782:	83 fb 25             	cmp    $0x25,%ebx
c0105785:	75 d4                	jne    c010575b <vprintfmt+0xa>
            }
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
c0105787:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
c010578b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
c0105792:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0105795:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
c0105798:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c010579f:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01057a2:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
c01057a5:	8b 45 10             	mov    0x10(%ebp),%eax
c01057a8:	8d 50 01             	lea    0x1(%eax),%edx
c01057ab:	89 55 10             	mov    %edx,0x10(%ebp)
c01057ae:	0f b6 00             	movzbl (%eax),%eax
c01057b1:	0f b6 d8             	movzbl %al,%ebx
c01057b4:	8d 43 dd             	lea    -0x23(%ebx),%eax
c01057b7:	83 f8 55             	cmp    $0x55,%eax
c01057ba:	0f 87 44 03 00 00    	ja     c0105b04 <vprintfmt+0x3b3>
c01057c0:	8b 04 85 88 72 10 c0 	mov    -0x3fef8d78(,%eax,4),%eax
c01057c7:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
c01057c9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
c01057cd:	eb d6                	jmp    c01057a5 <vprintfmt+0x54>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
c01057cf:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
c01057d3:	eb d0                	jmp    c01057a5 <vprintfmt+0x54>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
c01057d5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
c01057dc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c01057df:	89 d0                	mov    %edx,%eax
c01057e1:	c1 e0 02             	shl    $0x2,%eax
c01057e4:	01 d0                	add    %edx,%eax
c01057e6:	01 c0                	add    %eax,%eax
c01057e8:	01 d8                	add    %ebx,%eax
c01057ea:	83 e8 30             	sub    $0x30,%eax
c01057ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
c01057f0:	8b 45 10             	mov    0x10(%ebp),%eax
c01057f3:	0f b6 00             	movzbl (%eax),%eax
c01057f6:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
c01057f9:	83 fb 2f             	cmp    $0x2f,%ebx
c01057fc:	7e 0b                	jle    c0105809 <vprintfmt+0xb8>
c01057fe:	83 fb 39             	cmp    $0x39,%ebx
c0105801:	7f 06                	jg     c0105809 <vprintfmt+0xb8>
            padc = '0';
            goto reswitch;

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
c0105803:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
                ch = *fmt;
                if (ch < '0' || ch > '9') {
                    break;
                }
            }
c0105807:	eb d3                	jmp    c01057dc <vprintfmt+0x8b>
            goto process_precision;
c0105809:	eb 33                	jmp    c010583e <vprintfmt+0xed>

        case '*':
            precision = va_arg(ap, int);
c010580b:	8b 45 14             	mov    0x14(%ebp),%eax
c010580e:	8d 50 04             	lea    0x4(%eax),%edx
c0105811:	89 55 14             	mov    %edx,0x14(%ebp)
c0105814:	8b 00                	mov    (%eax),%eax
c0105816:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
c0105819:	eb 23                	jmp    c010583e <vprintfmt+0xed>

        case '.':
            if (width < 0)
c010581b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c010581f:	79 0c                	jns    c010582d <vprintfmt+0xdc>
                width = 0;
c0105821:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
c0105828:	e9 78 ff ff ff       	jmp    c01057a5 <vprintfmt+0x54>
c010582d:	e9 73 ff ff ff       	jmp    c01057a5 <vprintfmt+0x54>

        case '#':
            altflag = 1;
c0105832:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
c0105839:	e9 67 ff ff ff       	jmp    c01057a5 <vprintfmt+0x54>

        process_precision:
            if (width < 0)
c010583e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105842:	79 12                	jns    c0105856 <vprintfmt+0x105>
                width = precision, precision = -1;
c0105844:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0105847:	89 45 e8             	mov    %eax,-0x18(%ebp)
c010584a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
c0105851:	e9 4f ff ff ff       	jmp    c01057a5 <vprintfmt+0x54>
c0105856:	e9 4a ff ff ff       	jmp    c01057a5 <vprintfmt+0x54>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
c010585b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
c010585f:	e9 41 ff ff ff       	jmp    c01057a5 <vprintfmt+0x54>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
c0105864:	8b 45 14             	mov    0x14(%ebp),%eax
c0105867:	8d 50 04             	lea    0x4(%eax),%edx
c010586a:	89 55 14             	mov    %edx,0x14(%ebp)
c010586d:	8b 00                	mov    (%eax),%eax
c010586f:	8b 55 0c             	mov    0xc(%ebp),%edx
c0105872:	89 54 24 04          	mov    %edx,0x4(%esp)
c0105876:	89 04 24             	mov    %eax,(%esp)
c0105879:	8b 45 08             	mov    0x8(%ebp),%eax
c010587c:	ff d0                	call   *%eax
            break;
c010587e:	e9 ac 02 00 00       	jmp    c0105b2f <vprintfmt+0x3de>

        // error message
        case 'e':
            err = va_arg(ap, int);
c0105883:	8b 45 14             	mov    0x14(%ebp),%eax
c0105886:	8d 50 04             	lea    0x4(%eax),%edx
c0105889:	89 55 14             	mov    %edx,0x14(%ebp)
c010588c:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
c010588e:	85 db                	test   %ebx,%ebx
c0105890:	79 02                	jns    c0105894 <vprintfmt+0x143>
                err = -err;
c0105892:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
c0105894:	83 fb 06             	cmp    $0x6,%ebx
c0105897:	7f 0b                	jg     c01058a4 <vprintfmt+0x153>
c0105899:	8b 34 9d 48 72 10 c0 	mov    -0x3fef8db8(,%ebx,4),%esi
c01058a0:	85 f6                	test   %esi,%esi
c01058a2:	75 23                	jne    c01058c7 <vprintfmt+0x176>
                printfmt(putch, putdat, "error %d", err);
c01058a4:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
c01058a8:	c7 44 24 08 75 72 10 	movl   $0xc0107275,0x8(%esp)
c01058af:	c0 
c01058b0:	8b 45 0c             	mov    0xc(%ebp),%eax
c01058b3:	89 44 24 04          	mov    %eax,0x4(%esp)
c01058b7:	8b 45 08             	mov    0x8(%ebp),%eax
c01058ba:	89 04 24             	mov    %eax,(%esp)
c01058bd:	e8 61 fe ff ff       	call   c0105723 <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
c01058c2:	e9 68 02 00 00       	jmp    c0105b2f <vprintfmt+0x3de>
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
                printfmt(putch, putdat, "error %d", err);
            }
            else {
                printfmt(putch, putdat, "%s", p);
c01058c7:	89 74 24 0c          	mov    %esi,0xc(%esp)
c01058cb:	c7 44 24 08 7e 72 10 	movl   $0xc010727e,0x8(%esp)
c01058d2:	c0 
c01058d3:	8b 45 0c             	mov    0xc(%ebp),%eax
c01058d6:	89 44 24 04          	mov    %eax,0x4(%esp)
c01058da:	8b 45 08             	mov    0x8(%ebp),%eax
c01058dd:	89 04 24             	mov    %eax,(%esp)
c01058e0:	e8 3e fe ff ff       	call   c0105723 <printfmt>
            }
            break;
c01058e5:	e9 45 02 00 00       	jmp    c0105b2f <vprintfmt+0x3de>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
c01058ea:	8b 45 14             	mov    0x14(%ebp),%eax
c01058ed:	8d 50 04             	lea    0x4(%eax),%edx
c01058f0:	89 55 14             	mov    %edx,0x14(%ebp)
c01058f3:	8b 30                	mov    (%eax),%esi
c01058f5:	85 f6                	test   %esi,%esi
c01058f7:	75 05                	jne    c01058fe <vprintfmt+0x1ad>
                p = "(null)";
c01058f9:	be 81 72 10 c0       	mov    $0xc0107281,%esi
            }
            if (width > 0 && padc != '-') {
c01058fe:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105902:	7e 3e                	jle    c0105942 <vprintfmt+0x1f1>
c0105904:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
c0105908:	74 38                	je     c0105942 <vprintfmt+0x1f1>
                for (width -= strnlen(p, precision); width > 0; width --) {
c010590a:	8b 5d e8             	mov    -0x18(%ebp),%ebx
c010590d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0105910:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105914:	89 34 24             	mov    %esi,(%esp)
c0105917:	e8 15 03 00 00       	call   c0105c31 <strnlen>
c010591c:	29 c3                	sub    %eax,%ebx
c010591e:	89 d8                	mov    %ebx,%eax
c0105920:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0105923:	eb 17                	jmp    c010593c <vprintfmt+0x1eb>
                    putch(padc, putdat);
c0105925:	0f be 45 db          	movsbl -0x25(%ebp),%eax
c0105929:	8b 55 0c             	mov    0xc(%ebp),%edx
c010592c:	89 54 24 04          	mov    %edx,0x4(%esp)
c0105930:	89 04 24             	mov    %eax,(%esp)
c0105933:	8b 45 08             	mov    0x8(%ebp),%eax
c0105936:	ff d0                	call   *%eax
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
                p = "(null)";
            }
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
c0105938:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
c010593c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105940:	7f e3                	jg     c0105925 <vprintfmt+0x1d4>
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
c0105942:	eb 38                	jmp    c010597c <vprintfmt+0x22b>
                if (altflag && (ch < ' ' || ch > '~')) {
c0105944:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
c0105948:	74 1f                	je     c0105969 <vprintfmt+0x218>
c010594a:	83 fb 1f             	cmp    $0x1f,%ebx
c010594d:	7e 05                	jle    c0105954 <vprintfmt+0x203>
c010594f:	83 fb 7e             	cmp    $0x7e,%ebx
c0105952:	7e 15                	jle    c0105969 <vprintfmt+0x218>
                    putch('?', putdat);
c0105954:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105957:	89 44 24 04          	mov    %eax,0x4(%esp)
c010595b:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
c0105962:	8b 45 08             	mov    0x8(%ebp),%eax
c0105965:	ff d0                	call   *%eax
c0105967:	eb 0f                	jmp    c0105978 <vprintfmt+0x227>
                }
                else {
                    putch(ch, putdat);
c0105969:	8b 45 0c             	mov    0xc(%ebp),%eax
c010596c:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105970:	89 1c 24             	mov    %ebx,(%esp)
c0105973:	8b 45 08             	mov    0x8(%ebp),%eax
c0105976:	ff d0                	call   *%eax
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
c0105978:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
c010597c:	89 f0                	mov    %esi,%eax
c010597e:	8d 70 01             	lea    0x1(%eax),%esi
c0105981:	0f b6 00             	movzbl (%eax),%eax
c0105984:	0f be d8             	movsbl %al,%ebx
c0105987:	85 db                	test   %ebx,%ebx
c0105989:	74 10                	je     c010599b <vprintfmt+0x24a>
c010598b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c010598f:	78 b3                	js     c0105944 <vprintfmt+0x1f3>
c0105991:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
c0105995:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c0105999:	79 a9                	jns    c0105944 <vprintfmt+0x1f3>
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
c010599b:	eb 17                	jmp    c01059b4 <vprintfmt+0x263>
                putch(' ', putdat);
c010599d:	8b 45 0c             	mov    0xc(%ebp),%eax
c01059a0:	89 44 24 04          	mov    %eax,0x4(%esp)
c01059a4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
c01059ab:	8b 45 08             	mov    0x8(%ebp),%eax
c01059ae:	ff d0                	call   *%eax
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
c01059b0:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
c01059b4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c01059b8:	7f e3                	jg     c010599d <vprintfmt+0x24c>
                putch(' ', putdat);
            }
            break;
c01059ba:	e9 70 01 00 00       	jmp    c0105b2f <vprintfmt+0x3de>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
c01059bf:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01059c2:	89 44 24 04          	mov    %eax,0x4(%esp)
c01059c6:	8d 45 14             	lea    0x14(%ebp),%eax
c01059c9:	89 04 24             	mov    %eax,(%esp)
c01059cc:	e8 0b fd ff ff       	call   c01056dc <getint>
c01059d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01059d4:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
c01059d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01059da:	8b 55 f4             	mov    -0xc(%ebp),%edx
c01059dd:	85 d2                	test   %edx,%edx
c01059df:	79 26                	jns    c0105a07 <vprintfmt+0x2b6>
                putch('-', putdat);
c01059e1:	8b 45 0c             	mov    0xc(%ebp),%eax
c01059e4:	89 44 24 04          	mov    %eax,0x4(%esp)
c01059e8:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
c01059ef:	8b 45 08             	mov    0x8(%ebp),%eax
c01059f2:	ff d0                	call   *%eax
                num = -(long long)num;
c01059f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01059f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
c01059fa:	f7 d8                	neg    %eax
c01059fc:	83 d2 00             	adc    $0x0,%edx
c01059ff:	f7 da                	neg    %edx
c0105a01:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105a04:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
c0105a07:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
c0105a0e:	e9 a8 00 00 00       	jmp    c0105abb <vprintfmt+0x36a>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
c0105a13:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105a16:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105a1a:	8d 45 14             	lea    0x14(%ebp),%eax
c0105a1d:	89 04 24             	mov    %eax,(%esp)
c0105a20:	e8 68 fc ff ff       	call   c010568d <getuint>
c0105a25:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105a28:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
c0105a2b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
c0105a32:	e9 84 00 00 00       	jmp    c0105abb <vprintfmt+0x36a>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
c0105a37:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105a3a:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105a3e:	8d 45 14             	lea    0x14(%ebp),%eax
c0105a41:	89 04 24             	mov    %eax,(%esp)
c0105a44:	e8 44 fc ff ff       	call   c010568d <getuint>
c0105a49:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105a4c:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
c0105a4f:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
c0105a56:	eb 63                	jmp    c0105abb <vprintfmt+0x36a>

        // pointer
        case 'p':
            putch('0', putdat);
c0105a58:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105a5b:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105a5f:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
c0105a66:	8b 45 08             	mov    0x8(%ebp),%eax
c0105a69:	ff d0                	call   *%eax
            putch('x', putdat);
c0105a6b:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105a6e:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105a72:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
c0105a79:	8b 45 08             	mov    0x8(%ebp),%eax
c0105a7c:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
c0105a7e:	8b 45 14             	mov    0x14(%ebp),%eax
c0105a81:	8d 50 04             	lea    0x4(%eax),%edx
c0105a84:	89 55 14             	mov    %edx,0x14(%ebp)
c0105a87:	8b 00                	mov    (%eax),%eax
c0105a89:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105a8c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
c0105a93:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
c0105a9a:	eb 1f                	jmp    c0105abb <vprintfmt+0x36a>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
c0105a9c:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105a9f:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105aa3:	8d 45 14             	lea    0x14(%ebp),%eax
c0105aa6:	89 04 24             	mov    %eax,(%esp)
c0105aa9:	e8 df fb ff ff       	call   c010568d <getuint>
c0105aae:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105ab1:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
c0105ab4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
c0105abb:	0f be 55 db          	movsbl -0x25(%ebp),%edx
c0105abf:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105ac2:	89 54 24 18          	mov    %edx,0x18(%esp)
c0105ac6:	8b 55 e8             	mov    -0x18(%ebp),%edx
c0105ac9:	89 54 24 14          	mov    %edx,0x14(%esp)
c0105acd:	89 44 24 10          	mov    %eax,0x10(%esp)
c0105ad1:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105ad4:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0105ad7:	89 44 24 08          	mov    %eax,0x8(%esp)
c0105adb:	89 54 24 0c          	mov    %edx,0xc(%esp)
c0105adf:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105ae2:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105ae6:	8b 45 08             	mov    0x8(%ebp),%eax
c0105ae9:	89 04 24             	mov    %eax,(%esp)
c0105aec:	e8 97 fa ff ff       	call   c0105588 <printnum>
            break;
c0105af1:	eb 3c                	jmp    c0105b2f <vprintfmt+0x3de>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
c0105af3:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105af6:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105afa:	89 1c 24             	mov    %ebx,(%esp)
c0105afd:	8b 45 08             	mov    0x8(%ebp),%eax
c0105b00:	ff d0                	call   *%eax
            break;
c0105b02:	eb 2b                	jmp    c0105b2f <vprintfmt+0x3de>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
c0105b04:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105b07:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105b0b:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
c0105b12:	8b 45 08             	mov    0x8(%ebp),%eax
c0105b15:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
c0105b17:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
c0105b1b:	eb 04                	jmp    c0105b21 <vprintfmt+0x3d0>
c0105b1d:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
c0105b21:	8b 45 10             	mov    0x10(%ebp),%eax
c0105b24:	83 e8 01             	sub    $0x1,%eax
c0105b27:	0f b6 00             	movzbl (%eax),%eax
c0105b2a:	3c 25                	cmp    $0x25,%al
c0105b2c:	75 ef                	jne    c0105b1d <vprintfmt+0x3cc>
                /* do nothing */;
            break;
c0105b2e:	90                   	nop
        }
    }
c0105b2f:	90                   	nop
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
c0105b30:	e9 3e fc ff ff       	jmp    c0105773 <vprintfmt+0x22>
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
c0105b35:	83 c4 40             	add    $0x40,%esp
c0105b38:	5b                   	pop    %ebx
c0105b39:	5e                   	pop    %esi
c0105b3a:	5d                   	pop    %ebp
c0105b3b:	c3                   	ret    

c0105b3c <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:         the character will be printed
 * @b:          the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
c0105b3c:	55                   	push   %ebp
c0105b3d:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
c0105b3f:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105b42:	8b 40 08             	mov    0x8(%eax),%eax
c0105b45:	8d 50 01             	lea    0x1(%eax),%edx
c0105b48:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105b4b:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
c0105b4e:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105b51:	8b 10                	mov    (%eax),%edx
c0105b53:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105b56:	8b 40 04             	mov    0x4(%eax),%eax
c0105b59:	39 c2                	cmp    %eax,%edx
c0105b5b:	73 12                	jae    c0105b6f <sprintputch+0x33>
        *b->buf ++ = ch;
c0105b5d:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105b60:	8b 00                	mov    (%eax),%eax
c0105b62:	8d 48 01             	lea    0x1(%eax),%ecx
c0105b65:	8b 55 0c             	mov    0xc(%ebp),%edx
c0105b68:	89 0a                	mov    %ecx,(%edx)
c0105b6a:	8b 55 08             	mov    0x8(%ebp),%edx
c0105b6d:	88 10                	mov    %dl,(%eax)
    }
}
c0105b6f:	5d                   	pop    %ebp
c0105b70:	c3                   	ret    

c0105b71 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:       the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
c0105b71:	55                   	push   %ebp
c0105b72:	89 e5                	mov    %esp,%ebp
c0105b74:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
c0105b77:	8d 45 14             	lea    0x14(%ebp),%eax
c0105b7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
c0105b7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105b80:	89 44 24 0c          	mov    %eax,0xc(%esp)
c0105b84:	8b 45 10             	mov    0x10(%ebp),%eax
c0105b87:	89 44 24 08          	mov    %eax,0x8(%esp)
c0105b8b:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105b8e:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105b92:	8b 45 08             	mov    0x8(%ebp),%eax
c0105b95:	89 04 24             	mov    %eax,(%esp)
c0105b98:	e8 08 00 00 00       	call   c0105ba5 <vsnprintf>
c0105b9d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
c0105ba0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0105ba3:	c9                   	leave  
c0105ba4:	c3                   	ret    

c0105ba5 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
c0105ba5:	55                   	push   %ebp
c0105ba6:	89 e5                	mov    %esp,%ebp
c0105ba8:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
c0105bab:	8b 45 08             	mov    0x8(%ebp),%eax
c0105bae:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0105bb1:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105bb4:	8d 50 ff             	lea    -0x1(%eax),%edx
c0105bb7:	8b 45 08             	mov    0x8(%ebp),%eax
c0105bba:	01 d0                	add    %edx,%eax
c0105bbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105bbf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
c0105bc6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0105bca:	74 0a                	je     c0105bd6 <vsnprintf+0x31>
c0105bcc:	8b 55 ec             	mov    -0x14(%ebp),%edx
c0105bcf:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105bd2:	39 c2                	cmp    %eax,%edx
c0105bd4:	76 07                	jbe    c0105bdd <vsnprintf+0x38>
        return -E_INVAL;
c0105bd6:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
c0105bdb:	eb 2a                	jmp    c0105c07 <vsnprintf+0x62>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
c0105bdd:	8b 45 14             	mov    0x14(%ebp),%eax
c0105be0:	89 44 24 0c          	mov    %eax,0xc(%esp)
c0105be4:	8b 45 10             	mov    0x10(%ebp),%eax
c0105be7:	89 44 24 08          	mov    %eax,0x8(%esp)
c0105beb:	8d 45 ec             	lea    -0x14(%ebp),%eax
c0105bee:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105bf2:	c7 04 24 3c 5b 10 c0 	movl   $0xc0105b3c,(%esp)
c0105bf9:	e8 53 fb ff ff       	call   c0105751 <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
c0105bfe:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105c01:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
c0105c04:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0105c07:	c9                   	leave  
c0105c08:	c3                   	ret    

c0105c09 <strlen>:
 * @s:      the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
c0105c09:	55                   	push   %ebp
c0105c0a:	89 e5                	mov    %esp,%ebp
c0105c0c:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
c0105c0f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
c0105c16:	eb 04                	jmp    c0105c1c <strlen+0x13>
        cnt ++;
c0105c18:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
c0105c1c:	8b 45 08             	mov    0x8(%ebp),%eax
c0105c1f:	8d 50 01             	lea    0x1(%eax),%edx
c0105c22:	89 55 08             	mov    %edx,0x8(%ebp)
c0105c25:	0f b6 00             	movzbl (%eax),%eax
c0105c28:	84 c0                	test   %al,%al
c0105c2a:	75 ec                	jne    c0105c18 <strlen+0xf>
        cnt ++;
    }
    return cnt;
c0105c2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c0105c2f:	c9                   	leave  
c0105c30:	c3                   	ret    

c0105c31 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
c0105c31:	55                   	push   %ebp
c0105c32:	89 e5                	mov    %esp,%ebp
c0105c34:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
c0105c37:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
c0105c3e:	eb 04                	jmp    c0105c44 <strnlen+0x13>
        cnt ++;
c0105c40:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
    while (cnt < len && *s ++ != '\0') {
c0105c44:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0105c47:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0105c4a:	73 10                	jae    c0105c5c <strnlen+0x2b>
c0105c4c:	8b 45 08             	mov    0x8(%ebp),%eax
c0105c4f:	8d 50 01             	lea    0x1(%eax),%edx
c0105c52:	89 55 08             	mov    %edx,0x8(%ebp)
c0105c55:	0f b6 00             	movzbl (%eax),%eax
c0105c58:	84 c0                	test   %al,%al
c0105c5a:	75 e4                	jne    c0105c40 <strnlen+0xf>
        cnt ++;
    }
    return cnt;
c0105c5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c0105c5f:	c9                   	leave  
c0105c60:	c3                   	ret    

c0105c61 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
c0105c61:	55                   	push   %ebp
c0105c62:	89 e5                	mov    %esp,%ebp
c0105c64:	57                   	push   %edi
c0105c65:	56                   	push   %esi
c0105c66:	83 ec 20             	sub    $0x20,%esp
c0105c69:	8b 45 08             	mov    0x8(%ebp),%eax
c0105c6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0105c6f:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105c72:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
c0105c75:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0105c78:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0105c7b:	89 d1                	mov    %edx,%ecx
c0105c7d:	89 c2                	mov    %eax,%edx
c0105c7f:	89 ce                	mov    %ecx,%esi
c0105c81:	89 d7                	mov    %edx,%edi
c0105c83:	ac                   	lods   %ds:(%esi),%al
c0105c84:	aa                   	stos   %al,%es:(%edi)
c0105c85:	84 c0                	test   %al,%al
c0105c87:	75 fa                	jne    c0105c83 <strcpy+0x22>
c0105c89:	89 fa                	mov    %edi,%edx
c0105c8b:	89 f1                	mov    %esi,%ecx
c0105c8d:	89 4d ec             	mov    %ecx,-0x14(%ebp)
c0105c90:	89 55 e8             	mov    %edx,-0x18(%ebp)
c0105c93:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        "stosb;"
        "testb %%al, %%al;"
        "jne 1b;"
        : "=&S" (d0), "=&D" (d1), "=&a" (d2)
        : "0" (src), "1" (dst) : "memory");
    return dst;
c0105c96:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
c0105c99:	83 c4 20             	add    $0x20,%esp
c0105c9c:	5e                   	pop    %esi
c0105c9d:	5f                   	pop    %edi
c0105c9e:	5d                   	pop    %ebp
c0105c9f:	c3                   	ret    

c0105ca0 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
c0105ca0:	55                   	push   %ebp
c0105ca1:	89 e5                	mov    %esp,%ebp
c0105ca3:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
c0105ca6:	8b 45 08             	mov    0x8(%ebp),%eax
c0105ca9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
c0105cac:	eb 21                	jmp    c0105ccf <strncpy+0x2f>
        if ((*p = *src) != '\0') {
c0105cae:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105cb1:	0f b6 10             	movzbl (%eax),%edx
c0105cb4:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0105cb7:	88 10                	mov    %dl,(%eax)
c0105cb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0105cbc:	0f b6 00             	movzbl (%eax),%eax
c0105cbf:	84 c0                	test   %al,%al
c0105cc1:	74 04                	je     c0105cc7 <strncpy+0x27>
            src ++;
c0105cc3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
c0105cc7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c0105ccb:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
    char *p = dst;
    while (len > 0) {
c0105ccf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0105cd3:	75 d9                	jne    c0105cae <strncpy+0xe>
        if ((*p = *src) != '\0') {
            src ++;
        }
        p ++, len --;
    }
    return dst;
c0105cd5:	8b 45 08             	mov    0x8(%ebp),%eax
}
c0105cd8:	c9                   	leave  
c0105cd9:	c3                   	ret    

c0105cda <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
c0105cda:	55                   	push   %ebp
c0105cdb:	89 e5                	mov    %esp,%ebp
c0105cdd:	57                   	push   %edi
c0105cde:	56                   	push   %esi
c0105cdf:	83 ec 20             	sub    $0x20,%esp
c0105ce2:	8b 45 08             	mov    0x8(%ebp),%eax
c0105ce5:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0105ce8:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105ceb:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCMP
#define __HAVE_ARCH_STRCMP
static inline int
__strcmp(const char *s1, const char *s2) {
    int d0, d1, ret;
    asm volatile (
c0105cee:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0105cf1:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105cf4:	89 d1                	mov    %edx,%ecx
c0105cf6:	89 c2                	mov    %eax,%edx
c0105cf8:	89 ce                	mov    %ecx,%esi
c0105cfa:	89 d7                	mov    %edx,%edi
c0105cfc:	ac                   	lods   %ds:(%esi),%al
c0105cfd:	ae                   	scas   %es:(%edi),%al
c0105cfe:	75 08                	jne    c0105d08 <strcmp+0x2e>
c0105d00:	84 c0                	test   %al,%al
c0105d02:	75 f8                	jne    c0105cfc <strcmp+0x22>
c0105d04:	31 c0                	xor    %eax,%eax
c0105d06:	eb 04                	jmp    c0105d0c <strcmp+0x32>
c0105d08:	19 c0                	sbb    %eax,%eax
c0105d0a:	0c 01                	or     $0x1,%al
c0105d0c:	89 fa                	mov    %edi,%edx
c0105d0e:	89 f1                	mov    %esi,%ecx
c0105d10:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0105d13:	89 4d e8             	mov    %ecx,-0x18(%ebp)
c0105d16:	89 55 e4             	mov    %edx,-0x1c(%ebp)
        "orb $1, %%al;"
        "3:"
        : "=a" (ret), "=&S" (d0), "=&D" (d1)
        : "1" (s1), "2" (s2)
        : "memory");
    return ret;
c0105d19:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
c0105d1c:	83 c4 20             	add    $0x20,%esp
c0105d1f:	5e                   	pop    %esi
c0105d20:	5f                   	pop    %edi
c0105d21:	5d                   	pop    %ebp
c0105d22:	c3                   	ret    

c0105d23 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
c0105d23:	55                   	push   %ebp
c0105d24:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
c0105d26:	eb 0c                	jmp    c0105d34 <strncmp+0x11>
        n --, s1 ++, s2 ++;
c0105d28:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
c0105d2c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c0105d30:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
c0105d34:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0105d38:	74 1a                	je     c0105d54 <strncmp+0x31>
c0105d3a:	8b 45 08             	mov    0x8(%ebp),%eax
c0105d3d:	0f b6 00             	movzbl (%eax),%eax
c0105d40:	84 c0                	test   %al,%al
c0105d42:	74 10                	je     c0105d54 <strncmp+0x31>
c0105d44:	8b 45 08             	mov    0x8(%ebp),%eax
c0105d47:	0f b6 10             	movzbl (%eax),%edx
c0105d4a:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105d4d:	0f b6 00             	movzbl (%eax),%eax
c0105d50:	38 c2                	cmp    %al,%dl
c0105d52:	74 d4                	je     c0105d28 <strncmp+0x5>
        n --, s1 ++, s2 ++;
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
c0105d54:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0105d58:	74 18                	je     c0105d72 <strncmp+0x4f>
c0105d5a:	8b 45 08             	mov    0x8(%ebp),%eax
c0105d5d:	0f b6 00             	movzbl (%eax),%eax
c0105d60:	0f b6 d0             	movzbl %al,%edx
c0105d63:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105d66:	0f b6 00             	movzbl (%eax),%eax
c0105d69:	0f b6 c0             	movzbl %al,%eax
c0105d6c:	29 c2                	sub    %eax,%edx
c0105d6e:	89 d0                	mov    %edx,%eax
c0105d70:	eb 05                	jmp    c0105d77 <strncmp+0x54>
c0105d72:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0105d77:	5d                   	pop    %ebp
c0105d78:	c3                   	ret    

c0105d79 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
c0105d79:	55                   	push   %ebp
c0105d7a:	89 e5                	mov    %esp,%ebp
c0105d7c:	83 ec 04             	sub    $0x4,%esp
c0105d7f:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105d82:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
c0105d85:	eb 14                	jmp    c0105d9b <strchr+0x22>
        if (*s == c) {
c0105d87:	8b 45 08             	mov    0x8(%ebp),%eax
c0105d8a:	0f b6 00             	movzbl (%eax),%eax
c0105d8d:	3a 45 fc             	cmp    -0x4(%ebp),%al
c0105d90:	75 05                	jne    c0105d97 <strchr+0x1e>
            return (char *)s;
c0105d92:	8b 45 08             	mov    0x8(%ebp),%eax
c0105d95:	eb 13                	jmp    c0105daa <strchr+0x31>
        }
        s ++;
c0105d97:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
c0105d9b:	8b 45 08             	mov    0x8(%ebp),%eax
c0105d9e:	0f b6 00             	movzbl (%eax),%eax
c0105da1:	84 c0                	test   %al,%al
c0105da3:	75 e2                	jne    c0105d87 <strchr+0xe>
        if (*s == c) {
            return (char *)s;
        }
        s ++;
    }
    return NULL;
c0105da5:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0105daa:	c9                   	leave  
c0105dab:	c3                   	ret    

c0105dac <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
c0105dac:	55                   	push   %ebp
c0105dad:	89 e5                	mov    %esp,%ebp
c0105daf:	83 ec 04             	sub    $0x4,%esp
c0105db2:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105db5:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
c0105db8:	eb 11                	jmp    c0105dcb <strfind+0x1f>
        if (*s == c) {
c0105dba:	8b 45 08             	mov    0x8(%ebp),%eax
c0105dbd:	0f b6 00             	movzbl (%eax),%eax
c0105dc0:	3a 45 fc             	cmp    -0x4(%ebp),%al
c0105dc3:	75 02                	jne    c0105dc7 <strfind+0x1b>
            break;
c0105dc5:	eb 0e                	jmp    c0105dd5 <strfind+0x29>
        }
        s ++;
c0105dc7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
    while (*s != '\0') {
c0105dcb:	8b 45 08             	mov    0x8(%ebp),%eax
c0105dce:	0f b6 00             	movzbl (%eax),%eax
c0105dd1:	84 c0                	test   %al,%al
c0105dd3:	75 e5                	jne    c0105dba <strfind+0xe>
        if (*s == c) {
            break;
        }
        s ++;
    }
    return (char *)s;
c0105dd5:	8b 45 08             	mov    0x8(%ebp),%eax
}
c0105dd8:	c9                   	leave  
c0105dd9:	c3                   	ret    

c0105dda <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
c0105dda:	55                   	push   %ebp
c0105ddb:	89 e5                	mov    %esp,%ebp
c0105ddd:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
c0105de0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
c0105de7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
c0105dee:	eb 04                	jmp    c0105df4 <strtol+0x1a>
        s ++;
c0105df0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
strtol(const char *s, char **endptr, int base) {
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
c0105df4:	8b 45 08             	mov    0x8(%ebp),%eax
c0105df7:	0f b6 00             	movzbl (%eax),%eax
c0105dfa:	3c 20                	cmp    $0x20,%al
c0105dfc:	74 f2                	je     c0105df0 <strtol+0x16>
c0105dfe:	8b 45 08             	mov    0x8(%ebp),%eax
c0105e01:	0f b6 00             	movzbl (%eax),%eax
c0105e04:	3c 09                	cmp    $0x9,%al
c0105e06:	74 e8                	je     c0105df0 <strtol+0x16>
        s ++;
    }

    // plus/minus sign
    if (*s == '+') {
c0105e08:	8b 45 08             	mov    0x8(%ebp),%eax
c0105e0b:	0f b6 00             	movzbl (%eax),%eax
c0105e0e:	3c 2b                	cmp    $0x2b,%al
c0105e10:	75 06                	jne    c0105e18 <strtol+0x3e>
        s ++;
c0105e12:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c0105e16:	eb 15                	jmp    c0105e2d <strtol+0x53>
    }
    else if (*s == '-') {
c0105e18:	8b 45 08             	mov    0x8(%ebp),%eax
c0105e1b:	0f b6 00             	movzbl (%eax),%eax
c0105e1e:	3c 2d                	cmp    $0x2d,%al
c0105e20:	75 0b                	jne    c0105e2d <strtol+0x53>
        s ++, neg = 1;
c0105e22:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c0105e26:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
c0105e2d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0105e31:	74 06                	je     c0105e39 <strtol+0x5f>
c0105e33:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
c0105e37:	75 24                	jne    c0105e5d <strtol+0x83>
c0105e39:	8b 45 08             	mov    0x8(%ebp),%eax
c0105e3c:	0f b6 00             	movzbl (%eax),%eax
c0105e3f:	3c 30                	cmp    $0x30,%al
c0105e41:	75 1a                	jne    c0105e5d <strtol+0x83>
c0105e43:	8b 45 08             	mov    0x8(%ebp),%eax
c0105e46:	83 c0 01             	add    $0x1,%eax
c0105e49:	0f b6 00             	movzbl (%eax),%eax
c0105e4c:	3c 78                	cmp    $0x78,%al
c0105e4e:	75 0d                	jne    c0105e5d <strtol+0x83>
        s += 2, base = 16;
c0105e50:	83 45 08 02          	addl   $0x2,0x8(%ebp)
c0105e54:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
c0105e5b:	eb 2a                	jmp    c0105e87 <strtol+0xad>
    }
    else if (base == 0 && s[0] == '0') {
c0105e5d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0105e61:	75 17                	jne    c0105e7a <strtol+0xa0>
c0105e63:	8b 45 08             	mov    0x8(%ebp),%eax
c0105e66:	0f b6 00             	movzbl (%eax),%eax
c0105e69:	3c 30                	cmp    $0x30,%al
c0105e6b:	75 0d                	jne    c0105e7a <strtol+0xa0>
        s ++, base = 8;
c0105e6d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c0105e71:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
c0105e78:	eb 0d                	jmp    c0105e87 <strtol+0xad>
    }
    else if (base == 0) {
c0105e7a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0105e7e:	75 07                	jne    c0105e87 <strtol+0xad>
        base = 10;
c0105e80:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
c0105e87:	8b 45 08             	mov    0x8(%ebp),%eax
c0105e8a:	0f b6 00             	movzbl (%eax),%eax
c0105e8d:	3c 2f                	cmp    $0x2f,%al
c0105e8f:	7e 1b                	jle    c0105eac <strtol+0xd2>
c0105e91:	8b 45 08             	mov    0x8(%ebp),%eax
c0105e94:	0f b6 00             	movzbl (%eax),%eax
c0105e97:	3c 39                	cmp    $0x39,%al
c0105e99:	7f 11                	jg     c0105eac <strtol+0xd2>
            dig = *s - '0';
c0105e9b:	8b 45 08             	mov    0x8(%ebp),%eax
c0105e9e:	0f b6 00             	movzbl (%eax),%eax
c0105ea1:	0f be c0             	movsbl %al,%eax
c0105ea4:	83 e8 30             	sub    $0x30,%eax
c0105ea7:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0105eaa:	eb 48                	jmp    c0105ef4 <strtol+0x11a>
        }
        else if (*s >= 'a' && *s <= 'z') {
c0105eac:	8b 45 08             	mov    0x8(%ebp),%eax
c0105eaf:	0f b6 00             	movzbl (%eax),%eax
c0105eb2:	3c 60                	cmp    $0x60,%al
c0105eb4:	7e 1b                	jle    c0105ed1 <strtol+0xf7>
c0105eb6:	8b 45 08             	mov    0x8(%ebp),%eax
c0105eb9:	0f b6 00             	movzbl (%eax),%eax
c0105ebc:	3c 7a                	cmp    $0x7a,%al
c0105ebe:	7f 11                	jg     c0105ed1 <strtol+0xf7>
            dig = *s - 'a' + 10;
c0105ec0:	8b 45 08             	mov    0x8(%ebp),%eax
c0105ec3:	0f b6 00             	movzbl (%eax),%eax
c0105ec6:	0f be c0             	movsbl %al,%eax
c0105ec9:	83 e8 57             	sub    $0x57,%eax
c0105ecc:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0105ecf:	eb 23                	jmp    c0105ef4 <strtol+0x11a>
        }
        else if (*s >= 'A' && *s <= 'Z') {
c0105ed1:	8b 45 08             	mov    0x8(%ebp),%eax
c0105ed4:	0f b6 00             	movzbl (%eax),%eax
c0105ed7:	3c 40                	cmp    $0x40,%al
c0105ed9:	7e 3d                	jle    c0105f18 <strtol+0x13e>
c0105edb:	8b 45 08             	mov    0x8(%ebp),%eax
c0105ede:	0f b6 00             	movzbl (%eax),%eax
c0105ee1:	3c 5a                	cmp    $0x5a,%al
c0105ee3:	7f 33                	jg     c0105f18 <strtol+0x13e>
            dig = *s - 'A' + 10;
c0105ee5:	8b 45 08             	mov    0x8(%ebp),%eax
c0105ee8:	0f b6 00             	movzbl (%eax),%eax
c0105eeb:	0f be c0             	movsbl %al,%eax
c0105eee:	83 e8 37             	sub    $0x37,%eax
c0105ef1:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
c0105ef4:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0105ef7:	3b 45 10             	cmp    0x10(%ebp),%eax
c0105efa:	7c 02                	jl     c0105efe <strtol+0x124>
            break;
c0105efc:	eb 1a                	jmp    c0105f18 <strtol+0x13e>
        }
        s ++, val = (val * base) + dig;
c0105efe:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c0105f02:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0105f05:	0f af 45 10          	imul   0x10(%ebp),%eax
c0105f09:	89 c2                	mov    %eax,%edx
c0105f0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0105f0e:	01 d0                	add    %edx,%eax
c0105f10:	89 45 f8             	mov    %eax,-0x8(%ebp)
        // we don't properly detect overflow!
    }
c0105f13:	e9 6f ff ff ff       	jmp    c0105e87 <strtol+0xad>

    if (endptr) {
c0105f18:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c0105f1c:	74 08                	je     c0105f26 <strtol+0x14c>
        *endptr = (char *) s;
c0105f1e:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105f21:	8b 55 08             	mov    0x8(%ebp),%edx
c0105f24:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
c0105f26:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
c0105f2a:	74 07                	je     c0105f33 <strtol+0x159>
c0105f2c:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0105f2f:	f7 d8                	neg    %eax
c0105f31:	eb 03                	jmp    c0105f36 <strtol+0x15c>
c0105f33:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
c0105f36:	c9                   	leave  
c0105f37:	c3                   	ret    

c0105f38 <memset>:
 * @n:      number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
c0105f38:	55                   	push   %ebp
c0105f39:	89 e5                	mov    %esp,%ebp
c0105f3b:	57                   	push   %edi
c0105f3c:	83 ec 24             	sub    $0x24,%esp
c0105f3f:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105f42:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
c0105f45:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
c0105f49:	8b 55 08             	mov    0x8(%ebp),%edx
c0105f4c:	89 55 f8             	mov    %edx,-0x8(%ebp)
c0105f4f:	88 45 f7             	mov    %al,-0x9(%ebp)
c0105f52:	8b 45 10             	mov    0x10(%ebp),%eax
c0105f55:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
c0105f58:	8b 4d f0             	mov    -0x10(%ebp),%ecx
c0105f5b:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
c0105f5f:	8b 55 f8             	mov    -0x8(%ebp),%edx
c0105f62:	89 d7                	mov    %edx,%edi
c0105f64:	f3 aa                	rep stos %al,%es:(%edi)
c0105f66:	89 fa                	mov    %edi,%edx
c0105f68:	89 4d ec             	mov    %ecx,-0x14(%ebp)
c0105f6b:	89 55 e8             	mov    %edx,-0x18(%ebp)
        "rep; stosb;"
        : "=&c" (d0), "=&D" (d1)
        : "0" (n), "a" (c), "1" (s)
        : "memory");
    return s;
c0105f6e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
c0105f71:	83 c4 24             	add    $0x24,%esp
c0105f74:	5f                   	pop    %edi
c0105f75:	5d                   	pop    %ebp
c0105f76:	c3                   	ret    

c0105f77 <memmove>:
 * @n:      number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
c0105f77:	55                   	push   %ebp
c0105f78:	89 e5                	mov    %esp,%ebp
c0105f7a:	57                   	push   %edi
c0105f7b:	56                   	push   %esi
c0105f7c:	53                   	push   %ebx
c0105f7d:	83 ec 30             	sub    $0x30,%esp
c0105f80:	8b 45 08             	mov    0x8(%ebp),%eax
c0105f83:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105f86:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105f89:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0105f8c:	8b 45 10             	mov    0x10(%ebp),%eax
c0105f8f:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
c0105f92:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105f95:	3b 45 ec             	cmp    -0x14(%ebp),%eax
c0105f98:	73 42                	jae    c0105fdc <memmove+0x65>
c0105f9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105f9d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0105fa0:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105fa3:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0105fa6:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105fa9:	89 45 dc             	mov    %eax,-0x24(%ebp)
        "andl $3, %%ecx;"
        "jz 1f;"
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
c0105fac:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0105faf:	c1 e8 02             	shr    $0x2,%eax
c0105fb2:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
c0105fb4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0105fb7:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105fba:	89 d7                	mov    %edx,%edi
c0105fbc:	89 c6                	mov    %eax,%esi
c0105fbe:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
c0105fc0:	8b 4d dc             	mov    -0x24(%ebp),%ecx
c0105fc3:	83 e1 03             	and    $0x3,%ecx
c0105fc6:	74 02                	je     c0105fca <memmove+0x53>
c0105fc8:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
c0105fca:	89 f0                	mov    %esi,%eax
c0105fcc:	89 fa                	mov    %edi,%edx
c0105fce:	89 4d d8             	mov    %ecx,-0x28(%ebp)
c0105fd1:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c0105fd4:	89 45 d0             	mov    %eax,-0x30(%ebp)
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
        : "memory");
    return dst;
c0105fd7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0105fda:	eb 36                	jmp    c0106012 <memmove+0x9b>
    asm volatile (
        "std;"
        "rep; movsb;"
        "cld;"
        : "=&c" (d0), "=&S" (d1), "=&D" (d2)
        : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
c0105fdc:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105fdf:	8d 50 ff             	lea    -0x1(%eax),%edx
c0105fe2:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105fe5:	01 c2                	add    %eax,%edx
c0105fe7:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105fea:	8d 48 ff             	lea    -0x1(%eax),%ecx
c0105fed:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105ff0:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
        return __memcpy(dst, src, n);
    }
    int d0, d1, d2;
    asm volatile (
c0105ff3:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105ff6:	89 c1                	mov    %eax,%ecx
c0105ff8:	89 d8                	mov    %ebx,%eax
c0105ffa:	89 d6                	mov    %edx,%esi
c0105ffc:	89 c7                	mov    %eax,%edi
c0105ffe:	fd                   	std    
c0105fff:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
c0106001:	fc                   	cld    
c0106002:	89 f8                	mov    %edi,%eax
c0106004:	89 f2                	mov    %esi,%edx
c0106006:	89 4d cc             	mov    %ecx,-0x34(%ebp)
c0106009:	89 55 c8             	mov    %edx,-0x38(%ebp)
c010600c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
        "rep; movsb;"
        "cld;"
        : "=&c" (d0), "=&S" (d1), "=&D" (d2)
        : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
        : "memory");
    return dst;
c010600f:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
c0106012:	83 c4 30             	add    $0x30,%esp
c0106015:	5b                   	pop    %ebx
c0106016:	5e                   	pop    %esi
c0106017:	5f                   	pop    %edi
c0106018:	5d                   	pop    %ebp
c0106019:	c3                   	ret    

c010601a <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
c010601a:	55                   	push   %ebp
c010601b:	89 e5                	mov    %esp,%ebp
c010601d:	57                   	push   %edi
c010601e:	56                   	push   %esi
c010601f:	83 ec 20             	sub    $0x20,%esp
c0106022:	8b 45 08             	mov    0x8(%ebp),%eax
c0106025:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0106028:	8b 45 0c             	mov    0xc(%ebp),%eax
c010602b:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010602e:	8b 45 10             	mov    0x10(%ebp),%eax
c0106031:	89 45 ec             	mov    %eax,-0x14(%ebp)
        "andl $3, %%ecx;"
        "jz 1f;"
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
c0106034:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0106037:	c1 e8 02             	shr    $0x2,%eax
c010603a:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
c010603c:	8b 55 f4             	mov    -0xc(%ebp),%edx
c010603f:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0106042:	89 d7                	mov    %edx,%edi
c0106044:	89 c6                	mov    %eax,%esi
c0106046:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
c0106048:	8b 4d ec             	mov    -0x14(%ebp),%ecx
c010604b:	83 e1 03             	and    $0x3,%ecx
c010604e:	74 02                	je     c0106052 <memcpy+0x38>
c0106050:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
c0106052:	89 f0                	mov    %esi,%eax
c0106054:	89 fa                	mov    %edi,%edx
c0106056:	89 4d e8             	mov    %ecx,-0x18(%ebp)
c0106059:	89 55 e4             	mov    %edx,-0x1c(%ebp)
c010605c:	89 45 e0             	mov    %eax,-0x20(%ebp)
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
        : "memory");
    return dst;
c010605f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
c0106062:	83 c4 20             	add    $0x20,%esp
c0106065:	5e                   	pop    %esi
c0106066:	5f                   	pop    %edi
c0106067:	5d                   	pop    %ebp
c0106068:	c3                   	ret    

c0106069 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
c0106069:	55                   	push   %ebp
c010606a:	89 e5                	mov    %esp,%ebp
c010606c:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
c010606f:	8b 45 08             	mov    0x8(%ebp),%eax
c0106072:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
c0106075:	8b 45 0c             	mov    0xc(%ebp),%eax
c0106078:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
c010607b:	eb 30                	jmp    c01060ad <memcmp+0x44>
        if (*s1 != *s2) {
c010607d:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0106080:	0f b6 10             	movzbl (%eax),%edx
c0106083:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0106086:	0f b6 00             	movzbl (%eax),%eax
c0106089:	38 c2                	cmp    %al,%dl
c010608b:	74 18                	je     c01060a5 <memcmp+0x3c>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
c010608d:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0106090:	0f b6 00             	movzbl (%eax),%eax
c0106093:	0f b6 d0             	movzbl %al,%edx
c0106096:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0106099:	0f b6 00             	movzbl (%eax),%eax
c010609c:	0f b6 c0             	movzbl %al,%eax
c010609f:	29 c2                	sub    %eax,%edx
c01060a1:	89 d0                	mov    %edx,%eax
c01060a3:	eb 1a                	jmp    c01060bf <memcmp+0x56>
        }
        s1 ++, s2 ++;
c01060a5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c01060a9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
    const char *s1 = (const char *)v1;
    const char *s2 = (const char *)v2;
    while (n -- > 0) {
c01060ad:	8b 45 10             	mov    0x10(%ebp),%eax
c01060b0:	8d 50 ff             	lea    -0x1(%eax),%edx
c01060b3:	89 55 10             	mov    %edx,0x10(%ebp)
c01060b6:	85 c0                	test   %eax,%eax
c01060b8:	75 c3                	jne    c010607d <memcmp+0x14>
        if (*s1 != *s2) {
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
        }
        s1 ++, s2 ++;
    }
    return 0;
c01060ba:	b8 00 00 00 00       	mov    $0x0,%eax
}
c01060bf:	c9                   	leave  
c01060c0:	c3                   	ret    
