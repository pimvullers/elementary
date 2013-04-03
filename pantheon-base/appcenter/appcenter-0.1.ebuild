# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

VALA_MIN_API_VERSION="0.18"

inherit gnome2-utils vala cmake-utils

DESCRIPTION="The application store designed for the Pantheon desktop."
HOMEPAGE="https://launchpad.net/appcenter"
SRC_URI="https://launchpad.net/${PN}/0.x/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	app-admin/packagekit-base
	dev-db/sqlheavy:0.1
	dev-libs/libappstore
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libgee:0
	dev-libs/libpeas
	dev-libs/libunity
	x11-libs/granite
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS COPYING README )
	S="${WORKDIR}/${PN}"
}

src_prepare() {
	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="${VALAC}"
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
