# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.20

inherit gnome2-utils vala cmake-utils

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/elementary/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://launchpad.net/${PN}/loki/${PV}/+download/${P}.tar.xz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Configure the Pantheon desktop environment using Switchboard"
HOMEPAGE="http://launchpad.net/${PN}"

LICENSE="GPL-3"
SLOT="0"
IUSE="nls"

RDEPEND="
	x11-libs/granite
	>=pantheon-base/switchboard-2"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	use nls || sed -i '/add_subdirectory (po)/d' CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="${VALAC}"
		-DGSETTINGS_COMPILE=OFF
	)
	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_schemas_update
}

