include ../../SETTINGS
include ../../COMMON
include SETTINGS

all: $(DBCONVERT)

$(DBCONVERT): $(DBCONVERTDPR) $(addsuffix .pas, $(DBUNITS))
	$(DCC32) $(DCC32OPTS) $(DBCONVERTDPR)

clean:
	$(RM) $(DBCONVERT)
