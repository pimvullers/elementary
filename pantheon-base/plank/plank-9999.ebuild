EAPI=5

VALA_MIN_API_VERSION=0.16
VALA_USE_DEPEND=vapigen

inherit fdo-mime gnome2-utils vala autotools-utils bzr

DESCRIPTION="Stupidly simple"
HOMEPAGE="https://launchpad.net/plank"
EBZR_REPO_URI="lp:plank"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug nls static-libs"

RDEPEND="
	x11-libs/libX11
	dev-libs/libgee:0
	dev-libs/libunique:1
	x11-libs/libwnck:1
	>=x11-libs/bamf-0.2.58
	>=dev-libs/glib-2.26.0:2
	>=x11-libs/gtk+-2.22.0:2
	!pantheon-base/pantheon-dock"
DEPEND="${RDEPEND}
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

src_prepare() {
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

