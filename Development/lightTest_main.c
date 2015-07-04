/*
 * MATLAB Compiler: 4.13 (R2010a)
 * Date: Fri Oct  1 15:39:28 2010
 * Arguments: "-B" "macro_default" "-m" "-W" "main" "-T" "link:exe"
 * "lightTest.m" 
 */
#include <stdio.h>
#include "mclmcrrt.h"
#ifndef NOTRANSFORMPROCESSTYPE
#include <Carbon/Carbon.h>
#endif
#ifdef __cplusplus
extern "C" {
#endif

extern mclComponentData __MCC_lightTest_component_data;

#ifdef __cplusplus
}
#endif

static HMCRINSTANCE _mcr_inst = NULL;

#ifdef __cplusplus
extern "C" {
#endif

static int mclDefaultPrintHandler(const char *s)
{
  return mclWrite(1 /* stdout */, s, sizeof(char)*strlen(s));
}

#ifdef __cplusplus
} /* End extern "C" block */
#endif

#ifdef __cplusplus
extern "C" {
#endif

static int mclDefaultErrorHandler(const char *s)
{
  int written = 0;
  size_t len = 0;
  len = strlen(s);
  written = mclWrite(2 /* stderr */, s, sizeof(char)*len);
  if (len > 0 && s[ len-1 ] != '\n')
    written += mclWrite(2 /* stderr */, "\n", sizeof(char));
  return written;
}

#ifdef __cplusplus
} /* End extern "C" block */
#endif

#ifndef LIB_lightTest_C_API
#define LIB_lightTest_C_API /* No special import/export declaration */
#endif

LIB_lightTest_C_API 
bool MW_CALL_CONV lightTestInitializeWithHandlers(
    mclOutputHandlerFcn error_handler,
    mclOutputHandlerFcn print_handler)
{
    int bResult = 0;
  if (_mcr_inst != NULL)
    return true;
  if (!mclmcrInitialize())
    return false;
    {
        mclCtfStream ctfStream = 
            mclGetEmbeddedCtfStream((void *)(lightTestInitializeWithHandlers), 
                                    1105898);
        if (ctfStream) {
            bResult = mclInitializeComponentInstanceEmbedded(   &_mcr_inst,
                                                                
                                                     &__MCC_lightTest_component_data,
                                                                true, 
                                                                NoObjectType, 
                                                                ExeTarget,
                                                                error_handler, 
                                                                print_handler,
                                                                ctfStream, 
                                                                1105898);
            mclDestroyStream(ctfStream);
        } else {
            bResult = 0;
        }
    }  
    if (!bResult)
    return false;
  return true;
}

LIB_lightTest_C_API 
bool MW_CALL_CONV lightTestInitialize(void)
{
  return lightTestInitializeWithHandlers(mclDefaultErrorHandler, mclDefaultPrintHandler);
}
LIB_lightTest_C_API 
void MW_CALL_CONV lightTestTerminate(void)
{
  if (_mcr_inst != NULL)
    mclTerminateInstance(&_mcr_inst);
}

int run_main(int argc, const char **argv)
{
  int _retval;
  /* Generate and populate the path_to_component. */
  char path_to_component[(PATH_MAX*2)+1];
  separatePathName(argv[0], path_to_component, (PATH_MAX*2)+1);
  __MCC_lightTest_component_data.path_to_component = path_to_component; 
  if (!lightTestInitialize()) {
    return -1;
  }
  argc = mclSetCmdLineUserData(mclGetID(_mcr_inst), argc, argv);
  _retval = mclMain(_mcr_inst, argc, argv, "lightTest", 0);
  if (_retval == 0 /* no error */) mclWaitForFiguresToDie(NULL);
  lightTestTerminate();
  mclTerminateApplication();
  return _retval;
}

int main(int argc, const char **argv)
{
#ifndef NOTRANSFORMPROCESSTYPE
  ProcessSerialNumber psn = { 0, kCurrentProcess };
  OSStatus returnCode = TransformProcessType(& psn, kProcessTransformToForegroundApplication);
  if (returnCode) return 0;
#endif
  if (!mclInitializeApplication(
    __MCC_lightTest_component_data.runtime_options, 
    __MCC_lightTest_component_data.runtime_option_count))
    return 0;

  return mclRunMain(run_main, argc, argv);
}
