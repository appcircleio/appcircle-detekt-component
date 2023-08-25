# Appcircle _Detekt_ component

Runs detekt gradle task

## Required Inputs

- `AC_DETEKT_TASK`: Gradle task name. Specifies detekt task name.
- `AC_DETEKT_OUTPUT_PATH`: Detekt Output Path. If `AC_DETEKT_SAVE_REPORT` variable is set true and this value is not defined, default path (`<ac_module>/build/reports`) will be defined.

## Optional Inputs

- `AC_DETEKT_EXTRA_PARAMETERS`: Scanner Parameters. Extra command line parameters for detekt.
- `AC_DETEKT_SAVE_REPORT`: Save report. Report files will be saved into the artifacts folder if set to true.
