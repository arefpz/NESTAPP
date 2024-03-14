% Copyright (C) 2023  Aref Pariz, University of Ottawa & The Royal
% Institute for Mental Health, Ottawa, Ontario, Canada.
% apariz@uottawa.ca
%
% This program is distributed in the hope that it will be useful, but 
% WITHOUT ANY WARRANTY; without even the implied warranty of 
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General 
% Public License for more details.
% 
% You should have received a copy of the GNU General Public License along 
% with this program. If not, see <https://www.gnu.org/licenses/>.
% 
% This app is designed to use EEGLAB, TESA, and other available packages/
% plugins, to apply to EEG data. No new analysis is being introduced other
% than the mentioned functions. 
%
% STEPS INFORMATION
%
% This section provides information for each step, including the EEGLAB and
% TESA function names are used in the steps and some extra information is 
% related to the input, outputs, and the conditions that the original 
% functions should be used. The information here is gathered from 
% comments within each EEGLAB and TESA functions. For more information 
% please see the help documents for each function. 
% 
% NOTE 1: Naming is the same as the steps name with additional "info_" at
% the beginning and replacement of spaces, " ", and parenthesis "(", ")"
% with underline "_".%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
info_Load_Data=['EEGLAB: Uses "pop_loadX" function where X stands for the',...
    'format of data (i.e. set, cnt, vhdr). ',...
    'Will Load data based on the file selected on "Select Data to Perform',...
    'Analysis" Section.'];

info_Load_Channel_Location = ["A pop-up window will appear to select the file you want to be ised to detect the channels' location",...
    ' EEGLAB: "pop_chanedit" will be used to automatilly detect the ;ocations using the provided file and standard profile available in eeglab.'];

info_Save_New_Set=['EEGLAB: Uses "pop_newset" function to save the EEG data as a new set and file.',...
    'Will update EEG and ALLEEG in Workspace.'];

info_Remove_un_needed_Channels=['EEGLAB: Uses "pop_select" function to remove un-needed channels'];

info_Remove_Baseline=['EEGLAB: Uses pop_rmbase to Remove the baseline of all electrodes'];

info_Automatic_Cleaning_Data='EEGLAB: Uses "pop_clean_rawdata" to automatically Clean Raw Data. Input data must be continuous (not Epoched)';

info_De_Trend_Epoch='EEGLAB: Uses builtin "detrend" function to De-trending the channels and epoches';

info_TESA_De_Trend = 'TESA: Uses "pop_tesa_detrend" to detrend the data by fiting and subtracting a function from each channel.';

info_Re_Sample='EEGLAB: Uses "pop_resample" function to Re-Sample the recording rate to desired rate.';

info_Re_Reference='EEGLAB: Uses "pop_reref" function to Re-Referencing the data to desired montage';

info_Frequency_Filter_CleanLine=['CLEANLINE: Uses "Cleanline package" to filter the notch frequency, default 60, and its harmonic, default 120.'];

info_Frequency_Filter_TESA=['TESA: Use "pop_tesa_filtbutter" to filters the data using a zero-phase butterworth',...
    ' filter. Either a band pass, band stop, high pass, or low pass ',...
    ' filter can be implemented. The filter order is defined by the user.',...
    ' This function uses the matlab butter and filtfilt functions.',...
    ' If we want to perform both ERP and ICA,' ...
    " it's better to high pass filter with 0.5 and then",...
    ' perfom ICA and use the component to apply on the unfiltered data and',...
    'then highpass filter it with 0.1 for ERP.',...
    'Examples: ',...
    " EEG = pop_tesa_filtbutter( EEG, 1, 100, 4, 'bandpass' ); zero-phase, 4th-order bandpass butterworth filter between 1-100 Hz",...
    " EEG = pop_tesa_filtbutter( EEG, 48, 52, 4, 'bandstop' ); zero-phase, 4th-order bandstop butterworth filter between 48-52 Hz",...
    " EEG = pop_tesa_filtbutter( EEG, 1, [], 4, 'highpass' ); zero-phase, 4th-order high pass butterworth filter allowing frequencies above 1 Hz",...
    " EEG = pop_tesa_filtbutter( EEG, [], 45, 4, 'lowpass' ); zero-phase, 4th-order low pass butterworth filter allowing frequencies below 45 Hz"];

info_Frequency_Filter = ["EEGLAB: Uses pop_eegfilter to Filter data using Hamming windowed sinc FIR filter",...
"locutoff  - [float] lower edge of the frequency pass band (Hz) {[]/0 -> lowpass} ",...
"hicutoff  - [float] higher edge of the frequency pass band (Hz) {[]/0 -> highpass}",...
"filtorder' - filter order (filter length - 1). Mandatory even" + ...
"revfilt   - [0|1] invert filter (from bandpass to notch filter) {default 0 (bandpass)}",...
"usefft    - [0|1] ignored (backward compatibility only) 'plotfreqz' - [0|1] plot filter's frequency and phase respons {default 0} ",...
"minphase  - scalar boolean minimum-phase converted causal filter {default false}",...
"usefftfilt - [0|1] scalar boolean use fftfilt frequency domain filtering {default false or 0}"];

info_Epoching='EEGLAB: Uses "pop_epoch" function to epoch the signal.';

info_Remove_Bad_Channels=['EEGLAB: Uses "pop_rejchan" function to remove bad Channels.',...
    'With different standard deviation depending if the electrodes is in the',...
    'ROI or not the removed epochs and channels are saved into the eeg structure'];

info_Remove_Bad_Epoch='EEGLAB: Uses "pop_autorej" to Remove Bad Epochs';

info_Run_ICA='EEGLAB: Uses "pop_runica" function to perform ICA';

info_Run_TESA_ICA='TESA: Uses "pop_tesa_fastica" function to perform ICA';

info_Find_TMS_Pulses_TESA=['TESA: Uses "pop_tesa_findpulse" function to search for TMS (including paired and repetitive) pulses.',...
    ' Define the inter-stimulus interval which the function will use to label an artifact as single or paired.','''' ...
    ' For example, if you are using a LICI paradigm with an ISI of 100 ms, enter a value of 100 here.',...
    ' The function has a precision of 0.5 ms for determining whether two successive pulses fall within this ISI.',...
    ' If multiple different paired pulse conditions are present in the same file, this can be entered as: 3, 15, 100 etc.',...
    ' Note that the number of paired label inputs in 8 must match the number of ISIs entered.',...
    ' Enter a customised label for the paired pulse test stimulus.',...
    ' Turn on to search for trains of repetitive TMS pulses.',...
    ' If this is on, an inter-train interval must be given in 10 and the number of pulses in a train must be given in 11.',...
    ' Define the inter-train interval. This refers to the number of milliseconds between a train of stimulations.',...
    ' For example, if a 10 Hz paradigm was given in which stimulation was applied for 4 seconds (40 pulses) followed by a 26 second rest, the inter-train interval would be 2600.',...
    ' Define the number of pulses in a train. Using the above example, the number of pulses would be 40.'];

info_Fix_TMS_Pulse_TESA = ['TESA: Uses "tesa_fixevent" function to finds TMS pulses by detecting the large TMS artifacts present in already epoched data.',...
            ' This script is designed for instances when the recorded events do not correspond with when the TMS pulse was given.',...
            ' The script works by extracting a single channel and finding the time points in which the first derivatives exceed a certain threshold (defined by "rate")'];

info_Interpolate_Channels='EEGLAB: Uses "pop_interp" to interpolate data channels.';

info_Remove_TMS_Artifacts_TESA=['TESA: Uses "pop_tesa_removedata" function to removes data between defined time points and replaces',...
    ' data with 0s or the average of a defined period (e.g. a baseline period).',...
    ' Can run on either continous or epoched data.',...
    ' Removed time points are stored in EEG.tmscut.'];

info_Remove_ICA_Components_TESA='TESA: Uses "pop_tesa_compselect" to remove selected ICA components by "pop_tesa_fastica"';

info_Find_Artifacts_EDM_TESA = ['TESA: Uses "pop_tesa_edm" Function to find artifactual components automatically by',...
    ' using the enhanced deflation method (EDM). "nc" is the number of component to be find ([] for all).', ...
    ' "sr" is Sampling frequency in Hz ([] if Sf is in EEG structure).', ...
    ' "chanl" is Channel locations. [] is cahnlocation is already in EEG structure.', ...
    ' "cmp" describes the number of components to perform selection on (e.g. first 10 components). Leave empty for all components.', ...
    ' "tmsMuscleThresh" is the threshold for detecting components representing TMS-evoked muscle activity.', ...
    ' "tmsMuscleWin" is [start,end] Vector describing the target window for TMS-evoked muscle activity (in ms).', ...
    ' "tmsMuscleFeedback" is "on" or "off" turning on/off feedback of TMS-evoked muscle threshold value for each component in the command window.'];

info_Remove_Bad_Trials='EEGLAB: Uses "pop_rejepoch" to reject pre-labeled trials in a EEG dataset.';

info_Extract_TEP_TESA='TESA: Uses "pop_tesa_tepextract" to average over trials to generate a TMS-evoked potential (TEP).';

info_Find_TEP_Peaks_TESA = ['TESA: Uses "pop_tesa_peakanalysis" to find peaks within a time window defined by user',...
    'for either ROI or GMFA analyses.'];

info_SSP_SIR = ['TESA: Uses "pop_tesa_sspsir" Suppresses control data by removing the first n principal components of controlResponse.',...
    ' Both artefacts, TMS-evoked potentials (TEPs), and',...
    ' peripherally evoked potentials (PEPs) can be suppressed by',...
    ' SSP-SIR implemented in TESA.',...
    ' NOTE: This command is better to run if the data has not been highpass filltered below 200 Hz.'];

info_Interpolate_Missing_Data_TESA = ['TESA: Uses "pop_tesa_interpdata" function to replaces removed data using interpolated data.',...
'Note that either tesa_removedata or pop_tesa_removedata must be ran prior to this function.'];

info_Median_Filter_1D = ['TESA: Uses tesa_filtmedian() - applies a 1-d median filter of nth-order to remove',...
    'artifacts such as spikes and muscle artifacts.'];

info_Visualize_EEG_Data=['EEGLAB: Uses "pop_eegplot" to Plot the EEG data of all channels.'];

% info_Select_ICA_Comp=['EEGLAB: Uses "pop_selectcomps" function, to plot and select the ICA component(s).'];

% info_Visualize_ICA_Comp_TESA=['TESA: Uses TESA "pop_tesa_compplot" function to plot the ICA component.'];

% info_Plot_Component_Spectra_and_Maps='EEGLAB: Uses "pop_spectopo" to plot ICA Component Spectra and Maps.';

info_Remove_Recording_Noise_SOUND = ['Uses pop_tesa_sound() - performs noise suppression on the data using the SOUND algorithm.',...
    ' Note that data are rereferenced to average during SOUND',...
    'For further details on SOUND, see the function itself.'];

info_TEP_Peak_Output = 'TESA: Uses "pop_tesa_peakoutput" to find the results for the peak analysis. ';

info_Label_ICA_Components=['EEGLAB: Uses "pop_iclabel" to label ICA components.',...
    ' "Default" the full classifier validated in the accompanying publications',...
    '"Lite" - the lite version of the classifier which excludes autocorrelation as a feature for performance reasons.',...
    '"Beta" - included only to maintain the repoducibility of any studies which may previously have used it.'];

info_Flag_ICA_Components_for_Rejection = ['EEGLAB: Uses "pop_icaflag" to Flag components as atifacts'];

info_Remove_Flagged_ICA_Components = ['EEGLAB: Uses "pop_subcomp" to remove flagged components'];

info_Manual_Command = 'Enter your command(s) here to be run. Note that the command you enter here have access to variables created by EEGLAB, i.e. EEG.';

info_Choose_Data_Set = "EEGLAB: Uses pop_saveset' to retrive other dataset from ALLEEG.";

info_Automatic_Continuous_Rejection = 'EEGLAB: Uses "pop_rejcont" to reject continuous portions of data based on spectrum thresholding.';

% info_Plot_TEP_TESA = 'TESA: Uses "pop_tesa_plot" to plot TMS-evoked activity averaged over trials.';
%% Future features
% info_Pause='You need to enter "c" to continue!';
% info_Remove_high_std_Channels=['This command will calculate the standard deviation' ...
%     ' of all channels and based on the threshold value will remove high std channels using "pop_select" function.'];
