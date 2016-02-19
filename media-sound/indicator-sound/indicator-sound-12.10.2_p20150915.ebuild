# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

VALA_MIN_API_VERSION=0.20

inherit gnome2-utils vala cmake-utils

DESCRIPTION="A unified sound menu"
HOMEPAGE="https://launchpad.net/indicator-sound"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/indicator-sound_12.10.2+15.10.20150915.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="nls static-libs"

RDEPEND="
	>=dev-libs/glib-2.38:2
	dev-libs/libgee:0.8
	dev-libs/libxml2
	media-sound/pulseaudio[glib]
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/indicator-sound-12.10.2+15.10.20150915"

src_prepare() {
	epatch "${FILESDIR}/${PN}-12.10.2_p20150915-drop-url-dispatcher.patch"
	epatch "${FILESDIR}/${PN}-12.10.2_p20150915-drop-upstart.patch"
	epatch "${FILESDIR}/${PN}-12.10.2_p20150915-elementary.patch"

	sed -i '/dbustest/d' CMakeLists.txt
	sed -i 's/gee-1.0/gee-0.8/' CMakeLists.txt src/CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVALA_COMPILER="${VALAC}"
		-DVAPI_GEN="${VAPIGEN}"
		-DGSETTINGS_COMPILE=OFF
	)

	cmake-utils_src_configure 
}

src_install() {
	insinto /usr/share/glib-2.0/schemas/
	doins "${FILESDIR}/com.ubuntu.sound.gschema.xml"

	cmake-utils_src_install
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
