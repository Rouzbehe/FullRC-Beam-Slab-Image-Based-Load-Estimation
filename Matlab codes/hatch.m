%% |hatchfill|
%
% Neil's function allows you to pass in patch handles and convert them into
% hatches that are customizable. Let's look at this contour plot which
% contains several sections that I want to replace with hatches.

% Create two data sets
mData = membrane(1, 50);
pData = peaks(101)-10;

% Set colormap
colormap([0 0 0; summer; 1 1 1])
contourf(mData);
caxis([min(mData(:)), max(mData(:))]);

hold on
[c1, h1] = contourf(pData, [2.5 2.5]-10);
[c2, h2] = contourf(-pData, [2.5 2.5]+10);
hold off;

%%
% I can make one of them a diagonal hatch and the other one a cross hatch.

% Get patch objects from CONTOURGROUP
hPatch1 = findobj(h1, 'Type', 'patch');
hPatch2 = findobj(h2, 'Type', 'patch');

% Apply Hatch Fill
hh1 = hatchfill(hPatch1, 'single', -45, 3);
hh2 = hatchfill(hPatch2, 'cross', 45, 3);

% Remove outline
set([h1, h2], 'LineStyle', 'none')

% Change the cross hatch to white
set(hh2, 'Color', 'white')

%% |applyhatch_pluscolor| and |applyhatch_plusC|
%
% Both Brandon's and Brian's entries convert the distinct colors in the
% whole figure into hatch patterns. The nice thing about this is that they
% will also take care of legends.

% Create original plot
fH = gcf; colormap(jet(4));
h = bar(rand(3, 4));
legend('Apple', 'Orange', 'Banana', 'Melon', 'Location', 'EastOutside');

% Apply Brandon's function
tH = title('Brandon''s applyhatch');
applyhatch_pluscolor(fH, '\-x.', 0, [1 0 1 0], jet(4));

% Apply Brian's function
set(tH, 'String', 'Brian''s applyhatch');
applyhatch_plusC(fH, '\-x.', 'rkbk');

set(tH, 'String', 'Original');