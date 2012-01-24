# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/compiz-plugins-main/compiz-plugins-main-0.8.6-r1.ebuild,v 1.4 2011/03/21 19:50:33 nirbheek Exp $

EAPI="2"

inherit autotools eutils gnome2-utils

DESCRIPTION="Compiz Fusion Window Decorator Plugins"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="gconf"

MY_PV="0.8.4"

RDEPEND="
	>=gnome-base/librsvg-2.14.0:2
	virtual/jpeg:0
	x11-libs/cairo
	>=x11-libs/compiz-bcop-${MY_PV}
	>=x11-wm/compiz-${PV}[gconf?]
"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.19
	>=sys-devel/gettext-0.15
	gconf? ( gnome-base/gconf:2 )
"

src_prepare() {
	if ! use gconf; then
		epatch "${FILESDIR}"/${PN}-no-gconf.patch

		# required to apply the above patch
		intltoolize --copy --force || die "intltoolize failed"
		eautoreconf || die "eautoreconf failed"
	fi
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--enable-fast-install \
		--disable-static \
		$(use_enable gconf schemas)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	find "${D}" -name '*.la' -delete || die
}

pkg_preinst() {
	use gconf && gnome2_gconf_savelist
}

pkg_postinst() {
	use gconf && gnome2_gconf_install
}
