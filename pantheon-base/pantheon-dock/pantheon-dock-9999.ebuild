EAPI=5

VALA_MIN_API_VERSION=0.16
VALA_USE_DEPEND=vapigen

inherit fdo-mime gnome2-utils vala autotools-utils bzr

DESCRIPTION="The dock for elementary Pantheon, built on the awesome foundation of Plank"
HOMEPAGE="https://launchpad.net/pantheon-dock"
EBZR_REPO_URI="lp:pantheon-dock"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug nls static-libs"

CDEPEND="
	x11-libs/libX11
	dev-libs/libgee:0
	dev-libs/libunique:1
	x11-libs/libwnck:1
	>=x11-libs/bamf-0.2.58
	>=dev-libs/glib-2.26.0:2
	>=x11-libs/gtk+-2.22.0:2
	!pantheon-base/plank"
RDEPEND="${CDEPEND}
	x11-themes/pantheon-plank-theme"
DEPEND="${CDEPEND}
	$(vala_depend)
	dev-util/intltool
	virtual/pkgconfig
	gnome-base/gnome-common
	nls? ( sys-devel/gettext )"

pkg_setup() {
	AUTOTOOLS_AUTORECONF=yes
	AUTOTOOLS_IN_SOURCE_BUILD=yes

	DOCS=(AUTHORS COPYING COPYRIGHT NEWS README)
}

src_unpack() {
	local save_sandbox_write=${SANDBOX_WRITE}

	if [[ -d ${EBZR_STORE_DIR} ]] ; then
		addwrite /
		rm -r "${EBZR_STORE_DIR}" \
			|| die "${EBZR}: can't rm -r ${EBZR_STORE_DIR}"
		SANDBOX_WRITE=${save_sandbox_write}
	fi

	bzr_src_unpack
}

src_prepare() {
	# Drop apport hooks
	sed -i 's#data/apport/Makefile##' configure.ac
	sed -i 's#apport##' data/Makefile.am

	autotools-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable debug)
		$(use_enable nls)
	)

	autotools-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

